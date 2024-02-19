Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FE92C18E
	for <linux-ide@vger.kernel.org>; Mon, 19 Feb 2024 20:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708375671; cv=none; b=tMXAaIinreFJ4foJZvYc4rjw2QStm+OK5IRxyMu4rmP6AdxL6wNimXBlWdYvGRuBUVP7HBEQ6zO7VX80YrUmtNNqLHepMy4JtLqFqVElJa0xX1mP8nbm8h8QGVL3hzDFuqS8nmaeUmU5MCYsZxtHYK6el9Ulws/jhr37qevL+ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708375671; c=relaxed/simple;
	bh=hr3TQJcpeVBchiHfUMulkbtkqsPfXJJOMckcUvpJRak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fTmp3uEgBrB0BGCosuCfbuPSh0+N93IKbheYR7XZmJdiZqaXIhweTbNxdPDsT/4tkx/BYo/W1m7dsTtZBbJHQgHuNXJpueDnhExxSl2eORmMx0kZm/gDtwG7vt8xOSGHsrsD3jaNe3l0NUhPxLWyHcrWm1q9rn8iZ4QbwaODX28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NE6OCxEW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NE6OCxEW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3955C433C7;
	Mon, 19 Feb 2024 20:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708375670;
	bh=hr3TQJcpeVBchiHfUMulkbtkqsPfXJJOMckcUvpJRak=;
	h=From:To:Cc:Subject:Date:From;
	b=NE6OCxEWmqzOgxocOcBxd8/h2B7RkU/1XmNKhBqCO4ClMK6uLm4LvhwtZ+G/fF4DT
	 /95EDZbHK+4SureM8/FN/5Fb4U47ELrEomwXBmvnywffdZUF9sl71gtHfQVQksquP/
	 Nfust5ZH1iiYlKmxphA5p8b1hiEEnEmQXCiZWF4zEw9JhWQsyxM9udfC9Sen7yMMn/
	 ov+blO8i1zWM2f+IOnfR1PXq8xCdLvBe1AdvUWsnhVs+2nuIkBHwvFdJJQfSTMUWIK
	 k0dhTGFINkjis7QbSPeZGioEo9aU4VIHHDgo9fpYb/Ti2ScocJgEh6/rxK/MuioiX7
	 6ShZCrQ/9/OxA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Sergei Shtylyov <sergei.shtylyov@gmail.com>,
	Andrey Melnikov <temnota.am@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH v3] ahci: print the number of implemented ports
Date: Mon, 19 Feb 2024 21:47:43 +0100
Message-ID: <20240219204744.1365567-1-cassel@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We are currently printing the CAP.NP field.
CAP.NP is a 0's based value indicating the maximum number of ports
supported by the HBA silicon. Note that the number of ports indicated
in this field may be more than the number of ports indicated in the
PI (ports implemented) register. (See AHCI 1.3.1, section 3.1.1 -
Offset 00h: CAP – HBA Capabilities.)

PI (ports implemented) register is a field that has a bit set to '1'
if that specific port is implemented. This register is allowed to have
zeroes mixed with ones, i.e. a port in the middle is allowed to be
unimplemented. (See AHCI 1.3.1, section 3.1.4 - Offset 0Ch: PI – Ports
Implemented.)

Since the number of ports implemented might be smaller than the maximum
number of ports supported by the HBA silicon, print the number of
implemented ports as well.

While at it, clarify the properties being printed, and add a separator
(,), as that is currently missing, making it very easy to get confused
if the number before or after <property> belongs to <property>.

before:
ahci 0000:00:03.0: masking port_map 0x3f -> 0x2f
ahci 0000:00:03.0: AHCI 0001.0000 32 slots 6 ports 1.5 Gbps 0x2f impl SATA mode
ahci 0000:00:03.0: flags: 64bit ncq only

after:
ahci 0000:00:03.0: masking port_map 0x3f -> 0x2f
ahci 0000:00:03.0: AHCI vers 0001.0000, 32 command slots, 1.5 Gbps, SATA mode
ahci 0000:00:03.0: 5/6 ports implemented (port mask 0x2f)
ahci 0000:00:03.0: flags: 64bit ncq only

Suggested-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Changes since V2:
-Print both number of implemented ports and max number of ports.
-Clarify the properties being printed.
-Add a separator (,) between the printed properties.
-Prints two lines instead of one, as it would otherwise be a very
 long line being printed.

 drivers/ata/libahci.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index fca376f03c9e..83431aae74d8 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2620,8 +2620,8 @@ void ahci_print_info(struct ata_host *host, const char *scc_s)
 		speed_s = "?";
 
 	dev_info(host->dev,
-		"AHCI %02x%02x.%02x%02x "
-		"%u slots %u ports %s Gbps 0x%x impl %s mode\n"
+		"AHCI vers %02x%02x.%02x%02x, "
+		"%u command slots, %s Gbps, %s mode\n"
 		,
 
 		(vers >> 24) & 0xff,
@@ -2630,11 +2630,17 @@ void ahci_print_info(struct ata_host *host, const char *scc_s)
 		vers & 0xff,
 
 		((cap >> 8) & 0x1f) + 1,
-		(cap & 0x1f) + 1,
 		speed_s,
-		impl,
 		scc_s);
 
+	dev_info(host->dev,
+		"%u/%u ports implemented (port mask 0x%x)\n"
+		,
+
+		hweight32(impl),
+		(cap & 0x1f) + 1,
+		impl);
+
 	dev_info(host->dev,
 		"flags: "
 		"%s%s%s%s%s%s%s"
-- 
2.43.2

