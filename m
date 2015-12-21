From: Dan Aloni <dan@kernelim.com>
Subject: Re: IO errors after "block: remove bio_get_nr_vecs()"
Date: Mon, 21 Dec 2015 13:21:09 +0200
Message-ID: <20151221112109.GA24782@gmail.com>
References: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
 <20151220181801.GA12402@lst.de>
 <CA+55aFzVEUnfVNwSUtW3xsSOC6GDvGvE-scUasejA0G5BTi1AA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFzVEUnfVNwSUtW3xsSOC6GDvGvE-scUasejA0G5BTi1AA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Kent Overstreet <kent.overstreet@gmail.com>, Ming Lin <ming.l@ssi.samsung.com>, Jens Axboe <axboe@fb.com>, "Artem S. Tashkinov" <t.artem@mailcity.com>, Steven Whitehouse <swhiteho@redhat.com>, Tejun Heo <tj@kernel.org>, IDE-ML <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 20, 2015 at 10:41:44AM -0800, Linus Torvalds wrote:
>[..]
> Sadly, without CONFIG_LOCALVERSION_AUTO, there's no way to match up
> the dmesg files (in the same bisection tar-file as the bisection log)
> with the actual versions.

Perhaps we can print the Git revision in a manner independent of
CONFIG_LOCALVERSION_AUTO, using the attached patch. It will be emitted
in the dmesg Linux banner (though not in /proc/version, that's more
interface-ish and may break things).

-- 
Dan Aloni

--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-init-version.c-add-SCM_REVISION.patch"

>From d2d4ab995911e59ba41153fade176ca805ca2db8 Mon Sep 17 00:00:00 2001
From: Dan Aloni <dan@kernelim.com>
Date: Mon, 21 Dec 2015 11:54:18 +0200
Subject: [PATCH] init/version.c: add SCM revision

This adds a 'SCM-*' string to the Linux banner if and only if
source control information was available during the compilation
(such in the case of a Git bisect).
---
 Documentation/dontdiff  |  1 +
 Makefile                | 11 +++++++++++
 init/version.c          |  4 +++-
 scripts/setlocalversion |  9 +++++++++
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/dontdiff b/Documentation/dontdiff
index 8ea834f6b289..3dfda8883b7a 100644
--- a/Documentation/dontdiff
+++ b/Documentation/dontdiff
@@ -227,6 +227,7 @@ timeconst.h
 times.h*
 trix_boot.h
 utsrelease.h*
+scmrevision.h*
 vdso-syms.lds
 vdso.lds
 vdso32-int80-syms.lds
diff --git a/Makefile b/Makefile
index 4e2b18d56091..f966be40dafd 100644
--- a/Makefile
+++ b/Makefile
@@ -977,6 +977,7 @@ endif
 prepare2: prepare3 outputmakefile asm-generic
 
 prepare1: prepare2 $(version_h) include/generated/utsrelease.h \
+                   include/generated/scmrevision.h \
                    include/config/auto.conf
 	$(cmd_crmodverdir)
 
@@ -1003,6 +1004,13 @@ define filechk_utsrelease.h
 	(echo \#define UTS_RELEASE \"$(KERNELRELEASE)\";)
 endef
 
+define filechk_scmrevision.h
+	(SCMREV=`./scripts/setlocalversion --only-print`; \
+	 if [ "x$$SCMREV" = "x" ] ; \
+	    then echo \#define KERNEL_SCM_REVISION \"\" ; \
+	    else echo \#define KERNEL_SCM_REVISION \" SCM$$SCMREV\"; fi )
+endef
+
 define filechk_version.h
 	(echo \#define LINUX_VERSION_CODE $(shell                         \
 	expr $(VERSION) \* 65536 + 0$(PATCHLEVEL) \* 256 + 0$(SUBLEVEL)); \
@@ -1016,6 +1024,9 @@ $(version_h): $(srctree)/Makefile FORCE
 include/generated/utsrelease.h: include/config/kernel.release FORCE
 	$(call filechk,utsrelease.h)
 
+include/generated/scmrevision.h: include/config/kernel.release FORCE
+	$(call filechk,scmrevision.h)
+
 PHONY += headerdep
 headerdep:
 	$(Q)find $(srctree)/include/ -name '*.h' | xargs --max-args 1 \
diff --git a/init/version.c b/init/version.c
index fe41a63efed6..f9df083db7c8 100644
--- a/init/version.c
+++ b/init/version.c
@@ -11,6 +11,7 @@
 #include <linux/uts.h>
 #include <linux/utsname.h>
 #include <generated/utsrelease.h>
+#include <generated/scmrevision.h>
 #include <linux/version.h>
 #include <linux/proc_ns.h>
 
@@ -45,7 +46,8 @@ EXPORT_SYMBOL_GPL(init_uts_ns);
 /* FIXED STRINGS! Don't touch! */
 const char linux_banner[] =
 	"Linux version " UTS_RELEASE " (" LINUX_COMPILE_BY "@"
-	LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION "\n";
+	LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION
+	KERNEL_SCM_REVISION "\n";
 
 const char linux_proc_banner[] =
 	"%s version %s"
diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index 63d91e22ed7c..be6a4cc6c348 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -20,6 +20,10 @@ if test "$1" = "--save-scmversion"; then
 	scm_only=true
 	shift
 fi
+if test "$1" = "--only-print"; then
+	onlyprint=true
+	shift
+fi
 if test $# -gt 0; then
 	srctree=$1
 	shift
@@ -132,6 +136,11 @@ collect_files()
 	echo "$res"
 }
 
+if $only_print; then
+	scm_version
+	exit
+fi
+
 if $scm_only; then
 	if test ! -e .scmversion; then
 		res=$(scm_version)
-- 
2.4.3


--/04w6evG8XlLl3ft--
