From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/6] sysfs: implement sysfs flags and SYSFS_FLAG_REMOVED
Date: Sun, 1 Jul 2007 19:04:22 +0900
Message-ID: <11832842623874-git-send-email-htejun@gmail.com>
References: <11832842621378-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:49718 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755837AbXGAKE1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 06:04:27 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1879269wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 03:04:27 -0700 (PDT)
In-Reply-To: <11832842621378-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

Rename sysfs_dirent->s_type to s_flags, pack type into lower eight
bits and use the rest for flags.  sysfs_type() can used to access the
type.  This patch also implements SYSFS_FLAG_REMOVED which is used to
improve sanity check in sysfs_deactivate().  The flag will also be
used to make directory entries reclamiable.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 fs/sysfs/dir.c        |   37 +++++++++++++++++++++++--------------
 fs/sysfs/inode.c      |    5 +++--
 fs/sysfs/mount.c      |    2 +-
 fs/sysfs/sysfs.h      |    7 ++++++-
 include/linux/sysfs.h |    4 ++++
 5 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
index b4074ad..4a2bd8b 100644
--- a/fs/sysfs/dir.c
+++ b/fs/sysfs/dir.c
@@ -171,7 +171,7 @@ void sysfs_deactivate(struct sysfs_diren
 	DECLARE_COMPLETION_ONSTACK(wait);
 	int v;
 
-	BUG_ON(sd->s_sibling);
+	BUG_ON(sd->s_sibling || !(sd->s_flags & SYSFS_FLAG_REMOVED));
 	sd->s_sibling = (void *)&wait;
 
 	/* atomic_add_return() is a mb(), put_active() will always see
@@ -218,9 +218,9 @@ void release_sysfs_dirent(struct sysfs_d
  repeat:
 	parent_sd = sd->s_parent;
 
-	if (sd->s_type & SYSFS_KOBJ_LINK)
+	if (sysfs_type(sd) & SYSFS_KOBJ_LINK)
 		sysfs_put(sd->s_elem.symlink.target_sd);
-	if (sd->s_type & SYSFS_COPY_NAME)
+	if (sysfs_type(sd) & SYSFS_COPY_NAME)
 		kfree(sd->s_name);
 	kfree(sd->s_iattr);
 	sysfs_free_ino(sd->s_ino);
@@ -282,7 +282,7 @@ struct sysfs_dirent *sysfs_new_dirent(co
 
 	sd->s_name = name;
 	sd->s_mode = mode;
-	sd->s_type = type;
+	sd->s_flags = type;
 
 	return sd;
 
@@ -330,7 +330,7 @@ int sysfs_dirent_exist(struct sysfs_dire
 	struct sysfs_dirent * sd;
 
 	for (sd = parent_sd->s_children; sd; sd = sd->s_sibling) {
-		if (sd->s_type) {
+		if (sysfs_type(sd)) {
 			if (strcmp(sd->s_name, new))
 				continue;
 			else
@@ -446,11 +446,12 @@ static struct dentry * sysfs_lookup(stru
 {
 	struct sysfs_dirent * parent_sd = dentry->d_parent->d_fsdata;
 	struct sysfs_dirent * sd;
+	struct bin_attribute *bin_attr;
 	struct inode *inode;
 	int found = 0;
 
 	for (sd = parent_sd->s_children; sd; sd = sd->s_sibling) {
-		if ((sd->s_type & SYSFS_NOT_PINNED) &&
+		if ((sysfs_type(sd) & SYSFS_NOT_PINNED) &&
 		    !strcmp(sd->s_name, dentry->d_name.name)) {
 			found = 1;
 			break;
@@ -468,16 +469,22 @@ static struct dentry * sysfs_lookup(stru
 
 	if (inode->i_state & I_NEW) {
 		/* initialize inode according to type */
-		if (sd->s_type & SYSFS_KOBJ_ATTR) {
+		switch (sysfs_type(sd)) {
+		case SYSFS_KOBJ_ATTR:
 			inode->i_size = PAGE_SIZE;
 			inode->i_fop = &sysfs_file_operations;
-		} else if (sd->s_type & SYSFS_KOBJ_BIN_ATTR) {
-			struct bin_attribute *bin_attr =
-				sd->s_elem.bin_attr.bin_attr;
+			break;
+		case SYSFS_KOBJ_BIN_ATTR:
+			bin_attr = sd->s_elem.bin_attr.bin_attr;
 			inode->i_size = bin_attr->size;
 			inode->i_fop = &bin_fops;
-		} else if (sd->s_type & SYSFS_KOBJ_LINK)
+			break;
+		case SYSFS_KOBJ_LINK:
 			inode->i_op = &sysfs_symlink_inode_operations;
+			break;
+		default:
+			BUG();
+		}
 	}
 
 	sysfs_instantiate(dentry, inode);
@@ -499,6 +506,7 @@ static void remove_dir(struct dentry * d
 	mutex_lock(&parent->d_inode->i_mutex);
 
 	sysfs_unlink_sibling(sd);
+	sd->s_flags |= SYSFS_FLAG_REMOVED;
 
 	pr_debug(" o %s removing done (%d)\n",d->d_name.name,
 		 atomic_read(&d->d_count));
@@ -532,7 +540,8 @@ static void __sysfs_remove_dir(struct de
 	while (*pos) {
 		struct sysfs_dirent *sd = *pos;
 
-		if (sd->s_type && (sd->s_type & SYSFS_NOT_PINNED)) {
+		if (sysfs_type(sd) && (sysfs_type(sd) & SYSFS_NOT_PINNED)) {
+			sd->s_flags |= SYSFS_FLAG_REMOVED;
 			*pos = sd->s_sibling;
 			sd->s_sibling = removed;
 			removed = sd;
@@ -775,7 +784,7 @@ static int sysfs_readdir(struct file * f
 				const char * name;
 				int len;
 
-				if (!next->s_type)
+				if (!sysfs_type(next))
 					continue;
 
 				name = next->s_name;
@@ -824,7 +833,7 @@ static loff_t sysfs_dir_lseek(struct fil
 			pos = &sd->s_children;
 			while (n && *pos) {
 				struct sysfs_dirent *next = *pos;
-				if (next->s_type)
+				if (sysfs_type(next))
 					n--;
 				pos = &(*pos)->s_sibling;
 			}
diff --git a/fs/sysfs/inode.c b/fs/sysfs/inode.c
index 4d79a61..b67623d 100644
--- a/fs/sysfs/inode.c
+++ b/fs/sysfs/inode.c
@@ -264,7 +264,7 @@ void sysfs_drop_dentry(struct sysfs_dire
 	if (dentry) {
 		dentry->d_inode->i_ctime = curtime;
 		drop_nlink(dentry->d_inode);
-		if (sd->s_type & SYSFS_DIR) {
+		if (sysfs_type(sd) & SYSFS_DIR) {
 			drop_nlink(dentry->d_inode);
 			drop_nlink(dir);
 			/* XXX: unpin if directory, this will go away soon */
@@ -298,9 +298,10 @@ int sysfs_hash_and_remove(struct dentry
 	for (pos = &parent_sd->s_children; *pos; pos = &(*pos)->s_sibling) {
 		sd = *pos;
 
-		if (!sd->s_type)
+		if (!sysfs_type(sd))
 			continue;
 		if (!strcmp(sd->s_name, name)) {
+			sd->s_flags |= SYSFS_FLAG_REMOVED;
 			*pos = sd->s_sibling;
 			sd->s_sibling = NULL;
 			found = 1;
diff --git a/fs/sysfs/mount.c b/fs/sysfs/mount.c
index 2e66701..d5ce3aa 100644
--- a/fs/sysfs/mount.c
+++ b/fs/sysfs/mount.c
@@ -24,7 +24,7 @@ static const struct super_operations sys
 
 static struct sysfs_dirent sysfs_root = {
 	.s_count	= ATOMIC_INIT(1),
-	.s_type		= SYSFS_ROOT,
+	.s_flags	= SYSFS_ROOT,
 	.s_mode		= S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO,
 	.s_ino		= 1,
 };
diff --git a/fs/sysfs/sysfs.h b/fs/sysfs/sysfs.h
index 6f8aaf3..06b5085 100644
--- a/fs/sysfs/sysfs.h
+++ b/fs/sysfs/sysfs.h
@@ -34,7 +34,7 @@ struct sysfs_dirent {
 		struct sysfs_elem_bin_attr	bin_attr;
 	}			s_elem;
 
-	int			s_type;
+	unsigned int		s_flags;
 	umode_t			s_mode;
 	ino_t			s_ino;
 	struct dentry		* s_dentry;
@@ -86,6 +86,11 @@ extern const struct file_operations bin_
 extern const struct inode_operations sysfs_dir_inode_operations;
 extern const struct inode_operations sysfs_symlink_inode_operations;
 
+static inline unsigned int sysfs_type(struct sysfs_dirent *sd)
+{
+	return sd->s_flags & SYSFS_TYPE_MASK;
+}
+
 static inline struct sysfs_dirent * sysfs_get(struct sysfs_dirent * sd)
 {
 	if (sd) {
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 161e19a..2a6df64 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -74,6 +74,7 @@ struct sysfs_ops {
 	ssize_t	(*store)(struct kobject *,struct attribute *,const char *, size_t);
 };
 
+#define SYSFS_TYPE_MASK		0x00ff
 #define SYSFS_ROOT		0x0001
 #define SYSFS_DIR		0x0002
 #define SYSFS_KOBJ_ATTR 	0x0004
@@ -82,6 +83,9 @@ struct sysfs_ops {
 #define SYSFS_NOT_PINNED	(SYSFS_KOBJ_ATTR | SYSFS_KOBJ_BIN_ATTR | SYSFS_KOBJ_LINK)
 #define SYSFS_COPY_NAME		(SYSFS_DIR | SYSFS_KOBJ_LINK)
 
+#define SYSFS_FLAG_MASK		~SYSFS_TYPE_MASK
+#define SYSFS_FLAG_REMOVED	0x0100
+
 #ifdef CONFIG_SYSFS
 
 extern int sysfs_schedule_callback(struct kobject *kobj,
-- 
1.4.3.4


