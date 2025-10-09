Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4392C21DF
	for <linux-ide@vger.kernel.org>; Thu,  9 Oct 2025 10:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760006968; cv=none; b=XmmbzrVLEkjJm8cU/ad2Lbt0dNZxlGBPrJeexNWl1j99DkSUq8X3ITWouBv5RuXfef4w1uykar2WCkPHN5cJ++o0Fzer7jBJxqHrDA3IYd9k4cgRDdJ+ADDtm7iiC5rQhFZFMPv39bx1oYU/QA/qZLbudR+ekTk+MJ5qVHAdLpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760006968; c=relaxed/simple;
	bh=6CWI8MViMhZbcJEU8UoagstXmNJ3tp2wqyV8cvC8PgQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HmePbyGgKWo9m4dbjg6EfIYP+M1pXe5zFq/DI4+i4V2cT4n67MofSnygR2cOPG8HDCpnFVZLE3e+TUtPRgW1fYSDZwYxOFoWrNWugUOiyBz69RSWgIyrAjF80hIxHxZp/ckJkBnPrxNzMComEx78wK1aZDGaUUGpdmInWrdntVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYcae5/t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYcae5/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DDDC4CEE7;
	Thu,  9 Oct 2025 10:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760006968;
	bh=6CWI8MViMhZbcJEU8UoagstXmNJ3tp2wqyV8cvC8PgQ=;
	h=From:To:Subject:Date:From;
	b=gYcae5/tswGZMzZY6PEZfxysAPM4wgFOXYYjFTMJiazf/QkQKejMOjomBV99bnT56
	 DOWpybrfZwkg7cQJ4ETDMrdXwSw3zhJ7tKxKN3UUG6itk1diulZ9fgl9JMUkFpKYPC
	 olDvFMYJdVaw8LKzFp8qiQHlMbRA4DHoRqpSyzFQvHFfUYE9kWLS6tjlQgrt0/kxcW
	 sd8INO+xvjHwTnF1s83uAOs8hdAEJiOaEYdpIhipvmP9ym6udDk0UQcrqauYvppsOR
	 UfzCxz4c5yaoeaXLvmFBW2H8Z7VNxBGtQWZICpoaiqQAwb64k/Mf44cyd45OeCytGm
	 AR4+xwej+Cnbw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH] ata: libata-core: relax checks in ata_read_log_directory()
Date: Thu,  9 Oct 2025 19:46:00 +0900
Message-ID: <20251009104600.523444-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 6d4405b16d37 ("ata: libata-core: Cache the general purpose log
directory") introduced caching of a device general purpose log directory
to avoid repeated access to this log page during device scan. This
change also added a check on this log page to verify that the log page
version is 0x0001 as mandated by the ACS specifications.

And it turns out that some devices do not bother reporting this version,
instead reporting a version 0, resulting in error messages such as:

ata6.00: Invalid log directory version 0x0000

and to the device being marked as not supporting the general purpose log
directory log page.

Since before commit 6d4405b16d37 the log page version check did not
exist and things were still working correctly for these devices, relax
ata_read_log_directory() version check and only warn about the invalid
log page version number without disabling access to the log directory
page.

Fixes: 6d4405b16d37 ("ata: libata-core: Cache the general purpose log directory")
Cc: stable@vger.kernel.org
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220635
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/ata/libata-core.c | 11 ++++-------
 include/linux/libata.h    |  6 ++++++
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index ff53f5f029b4..2a210719c4ce 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2174,13 +2174,10 @@ static int ata_read_log_directory(struct ata_device *dev)
 	}
 
 	version = get_unaligned_le16(&dev->gp_log_dir[0]);
-	if (version != 0x0001) {
-		ata_dev_err(dev, "Invalid log directory version 0x%04x\n",
-			    version);
-		ata_clear_log_directory(dev);
-		dev->quirks |= ATA_QUIRK_NO_LOG_DIR;
-		return -EINVAL;
-	}
+	if (version != 0x0001)
+		ata_dev_warn_once(dev,
+				  "Invalid log directory version 0x%04x\n",
+				  version);
 
 	return 0;
 }
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 21de0935775d..7a98de1cc995 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1594,6 +1594,12 @@ do {								\
 #define ata_dev_dbg(dev, fmt, ...)				\
 	ata_dev_printk(debug, dev, fmt, ##__VA_ARGS__)
 
+#define ata_dev_warn_once(dev, fmt, ...)			\
+	pr_warn_once("ata%u.%02u: " fmt,			\
+		     (dev)->link->ap->print_id,			\
+		     (dev)->link->pmp + (dev)->devno,		\
+		     ##__VA_ARGS__)
+
 static inline void ata_print_version_once(const struct device *dev,
 					  const char *version)
 {
-- 
2.51.0

