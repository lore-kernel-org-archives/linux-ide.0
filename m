From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/6] sysfs: implement sysfs_find_dirent() and sysfs_get_dirent()
Date: Sun, 1 Jul 2007 19:04:22 +0900
Message-ID: <1183284262898-git-send-email-htejun@gmail.com>
References: <11832842621378-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:49318 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755956AbXGAKE2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Jul 2007 06:04:28 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1879264wah
        for <linux-ide@vger.kernel.org>; Sun, 01 Jul 2007 03:04:27 -0700 (PDT)
In-Reply-To: <11832842621378-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>

Implement sysfs_find_dirent() and sysfs_get_dirent().
sysfs_dirent_exist() is replaced by sysfs_find_dirent().  These will
be used to make directory entries reclamiable.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 fs/sysfs/dir.c     |   61 +++++++++++++++++++++++++++++++++++++--------------
 fs/sysfs/file.c    |    2 +-
 fs/sysfs/symlink.c |    2 +-
 fs/sysfs/sysfs.h   |    5 +++-
 4 files changed, 50 insertions(+), 20 deletions(-)

diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
index 4a2bd8b..c05d04a 100644
--- a/fs/sysfs/dir.c
+++ b/fs/sysfs/dir.c
@@ -317,28 +317,55 @@ void sysfs_attach_dirent(struct sysfs_di
 	}
 }
 
-/*
+/**
+ *	sysfs_find_dirent - find sysfs_dirent with the given name
+ *	@parent_sd: sysfs_dirent to search under
+ *	@name: name to look for
  *
- * Return -EEXIST if there is already a sysfs element with the same name for
- * the same parent.
+ *	Look for sysfs_dirent with name @name under @parent_sd.
  *
- * called with parent inode's i_mutex held
+ *	LOCKING:
+ *	mutex_lock(parent->i_mutex)
+ *
+ *	RETURNS:
+ *	Pointer to sysfs_dirent if found, NULL if not.
  */
-int sysfs_dirent_exist(struct sysfs_dirent *parent_sd,
-			  const unsigned char *new)
+struct sysfs_dirent *sysfs_find_dirent(struct sysfs_dirent *parent_sd,
+				       const unsigned char *name)
 {
-	struct sysfs_dirent * sd;
+	struct sysfs_dirent *sd;
 
-	for (sd = parent_sd->s_children; sd; sd = sd->s_sibling) {
-		if (sysfs_type(sd)) {
-			if (strcmp(sd->s_name, new))
-				continue;
-			else
-				return -EEXIST;
-		}
-	}
+	for (sd = parent_sd->s_children; sd; sd = sd->s_sibling)
+		if (sysfs_type(sd) && !strcmp(sd->s_name, name))
+			return sd;
+	return NULL;
+}
 
-	return 0;
+/**
+ *	sysfs_get_dirent - find and get sysfs_dirent with the given name
+ *	@parent_sd: sysfs_dirent to search under
+ *	@name: name to look for
+ *
+ *	Look for sysfs_dirent with name @name under @parent_sd and get
+ *	it if found.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	Pointer to sysfs_dirent if found, NULL if not.
+ */
+struct sysfs_dirent *sysfs_get_dirent(struct sysfs_dirent *parent_sd,
+				      const unsigned char *name)
+{
+	struct sysfs_dirent *sd;
+
+	mutex_lock(&parent_sd->s_dentry->d_inode->i_mutex);
+	sd = sysfs_find_dirent(parent_sd, name);
+	sysfs_get(sd);
+	mutex_unlock(&parent_sd->s_dentry->d_inode->i_mutex);
+
+	return sd;
 }
 
 static int create_dir(struct kobject *kobj, struct dentry *parent,
@@ -382,7 +409,7 @@ static int create_dir(struct kobject *ko
 
 	/* link in */
 	error = -EEXIST;
-	if (sysfs_dirent_exist(parent->d_fsdata, name))
+	if (sysfs_find_dirent(parent->d_fsdata, name))
 		goto out_iput;
 
 	sysfs_instantiate(dentry, inode);
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index a84b734..e448b88 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -421,7 +421,7 @@ int sysfs_add_file(struct dentry * dir,
 
 	mutex_lock(&dir->d_inode->i_mutex);
 
-	if (sysfs_dirent_exist(parent_sd, attr->name)) {
+	if (sysfs_find_dirent(parent_sd, attr->name)) {
 		error = -EEXIST;
 		goto out_unlock;
 	}
diff --git a/fs/sysfs/symlink.c b/fs/sysfs/symlink.c
index ff605d3..45b62e2 100644
--- a/fs/sysfs/symlink.c
+++ b/fs/sysfs/symlink.c
@@ -95,7 +95,7 @@ int sysfs_create_link(struct kobject * k
 		return -ENOENT;
 
 	mutex_lock(&dentry->d_inode->i_mutex);
-	if (!sysfs_dirent_exist(dentry->d_fsdata, name))
+	if (!sysfs_find_dirent(dentry->d_fsdata, name))
 		error = sysfs_add_link(parent_sd, name, target_sd);
 	mutex_unlock(&dentry->d_inode->i_mutex);
 
diff --git a/fs/sysfs/sysfs.h b/fs/sysfs/sysfs.h
index 06b5085..f1629b4 100644
--- a/fs/sysfs/sysfs.h
+++ b/fs/sysfs/sysfs.h
@@ -59,7 +59,10 @@ extern struct inode * sysfs_get_inode(st
 extern void sysfs_instantiate(struct dentry *dentry, struct inode *inode);
 
 extern void release_sysfs_dirent(struct sysfs_dirent * sd);
-extern int sysfs_dirent_exist(struct sysfs_dirent *, const unsigned char *);
+extern struct sysfs_dirent *sysfs_find_dirent(struct sysfs_dirent *parent_sd,
+					      const unsigned char *name);
+extern struct sysfs_dirent *sysfs_get_dirent(struct sysfs_dirent *parent_sd,
+					     const unsigned char *name);
 extern struct sysfs_dirent *sysfs_new_dirent(const char *name, umode_t mode,
 					     int type);
 extern void sysfs_attach_dirent(struct sysfs_dirent *sd,
-- 
1.4.3.4


