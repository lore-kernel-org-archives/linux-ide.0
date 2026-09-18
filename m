Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D9C30B53E
	for <linux-ide@vger.kernel.org>; Fri, 18 Sep 2026 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789735241; cv=none; b=fgv6M6ChPaJ4xFzaqQd8gWLGs277WDNxAMalQNRQp/JvJpJ77lWZRDDWv7wzQk6gPi4llvS7hdIhaCVSHe1YgdfQI0Y9cssZpHr+03mmkZhrV/1LW86vKUYFiMweb4172prDZODRHpDE8VLEJ/UyjQQRoZGcA/blJVoJ+J/jpjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789735241; c=relaxed/simple;
	bh=HSeyWRWHVsQSlrCyRVTo3sAtZVpwRMuN06o69EKNCAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SuyQ+OEiiO7SEEz56Sz3YTBcIwiSzsgz/Kz+ufgcyevN0SKMbjd8q99YQhYLH0nSFoKJ1KH0L1fOvfW2wEaMXWDtYq1kq9CxsxqWi/iKrRwJRzS7AB9Qooq0POBkwFT3NP9dh54AU3Z7D2gvK70tvF96IuaolZwD22gGSohs4o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYpuKzGD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYpuKzGD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7147F1F000FF;
	Fri, 18 Sep 2026 12:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789735240;
	bh=CoXNXngFoeHdWcsTakrSgRDGuTu/8OCOnnXgJ6iCJJE=;
	h=From:To:Cc:Subject:Date;
	b=CYpuKzGDXE4kdTQm0YsWwqKZXhUb6UmBDKJVoN7hGvynaUUmyA80nQ/qOwQWkV6ey
	 ngnRzNiVd70hZPEimzU6++dWsU4BkOOgCLmMSTpBYWDmK4pTUvjiK3lrL4c3ft2Ko7
	 xCwf+zqzPlkeIqMU8jj4dp9NdbdMNyDu4jSdKfm2fE5h4fOibueG0FgMxH6WBSE8Vr
	 VdC9i9fZ0vlY6dxB0sLFhN8ma/4/htyTPAJb3gIvV98gYHMMcihZp1/KT4ha8xBu2a
	 Gwy6BsffvMRQdm3GfsiHs85KY55r+qf0euANmRL2VggcDhVQt7E/81CAZpSkDdv6EP
	 JtUj27Qj9vf5A==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	grandmastertriplej@gmail.com,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Natikar, Basavaraj" <basavaraj.natikar@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 0/2] ata: Extend Samsung LPM quirk to AMD and fix force documentation
Date: Fri, 18 Sep 2026 14:40:31 +0200
Message-ID: <20260918124030.1962773-4-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1635; i=cassel@kernel.org; h=from:subject; bh=HSeyWRWHVsQSlrCyRVTo3sAtZVpwRMuN06o69EKNCAE=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLLWGtpd55v9OIFjVdTUYP4vWw64SMR+3bbozPW2ZAblI 01fHofJdJSyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAirgmMDB/4rH9/Ko7PuP6L uz1vqfGjniSeIqFU7S0qP2/MutvhfY6R4VvFF/7UNSkLDm7RiElwnLrpk+02Mc/g6h+/Xgn+Pvt 8IQMA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello,

A user reports that a Samsung SSD 870 QVO 8TB connected to an AMD 600
Series chipset SATA controller times out on STANDBY IMMEDIATE during
system suspend with med_power_with_dipm enabled. The command completes
with max_performance instead.

Patch 1 extends the existing Samsung LPM quirk from ATI to AMD
controllers, renaming it to ATA_QUIRK_NO_LPM_ON_ATI_AND_AMD. It keeps the
same drive model matches and leaves the NCQ quirk restricted to ATI.
LPM behavior on other controller vendors, including Intel, is unchanged.
The underlying controller/device interaction has not been root-caused.

Patch 2 separately corrects the libata.force parameter documentation:
the supported PIO range, the scope of ncqati, and the set-only behavior
of max_sec_1024 and max_sec_lba48. It introduces no new force options.

Note that the ATI (and now AMD) LPM quirk never had a libata.force option,
and neither do we want to add one.
If a user wants to force enable/disable lpm, they can use the existing
[no]lpm libata.force parameter. We therefore do not have and documentation
in kernel-parameters.txt to change.

Bug report:
https://bugzilla.kernel.org/show_bug.cgi?id=221986

Kind regards,
Niklas

Niklas Cassel (2):
  ata: libata-core: Extend Samsung LPM quirk to AMD controllers
  ata: libata: Correct libata.force parameter documentation

 Documentation/admin-guide/kernel-parameters.txt | 10 ++++------
 drivers/ata/libata-core.c                       | 15 ++++++++-------
 include/linux/libata.h                          |  4 ++--
 3 files changed, 14 insertions(+), 15 deletions(-)

-- 
2.55.0

