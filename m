Received: from mail-108-mta11.mxroute.com (mail-108-mta11.mxroute.com [136.175.108.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408F134EF05
	for <linux-ide@vger.kernel.org>; Tue,  6 Jan 2026 20:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767729745; cv=none; b=lkLoHBEZqFqhDGcbydfjsKtRjlPxU1z6gJWuUShVRcGExVwU5lc8UWMMywDrnzSqTnf+XO0lFxHO+JkUiVdFSvTOaibySSoNKWnUJw5OkrBmGgcKnhERIWxdxrhZfZ3V9UX/3yEiRbofQihrRJltRHCu4q6Zwf+b6PiyZi8X4tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767729745; c=relaxed/simple;
	bh=KgslWiZJSachWcLx0sgdMQzJ48U4UP3wAdNzBrpZlS8=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type; b=K3JT8r4JYdxtA7Pj1n7EF7iAMFbo3dt7dZdeq//w+9zL7QCwg7GV5vxUFMLvf0OIP7HeOMZFADW4FZm9wiPBj5x+pYroie6xQrRfTRxRbxaID9FX2GnD8g8a5B1rTeKtlvWGIasBy9E9Zkp4vggUUJOeeCeOxvQ2tvxEntlE0dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yoxt.cc; spf=pass smtp.mailfrom=yoxt.cc; dkim=pass (2048-bit key) header.d=yoxt.cc header.i=@yoxt.cc header.b=FAV205d3; arc=none smtp.client-ip=136.175.108.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yoxt.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoxt.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoxt.cc header.i=@yoxt.cc header.b="FAV205d3"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta11.mxroute.com (ZoneMTA) with ESMTPSA id 19b94e27acf0004eea.003
 for <linux-ide@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 06 Jan 2026 19:57:09 +0000
X-Zone-Loop: a552e5510674bf1e7b2e0e2caa84b75f34ea7864de21
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=yoxt.cc;
	s=x; h=Content-Transfer-Encoding:Content-Type:Subject:Cc:To:From:Date:
	MIME-Version:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References; bh=l9xpUbcT2Goz+ycuKP2edIKbuj1HoialB1ajw8Cl6HE=; b=FAV205d3pjdS/x
	WY521a0NkntX8xDpNSNKoxoEyrjffdUqClqZE3wUE6+SyodWBfnl3s3nnQB8xFPVYfokU5zfG4VNq
	GNLjYHRqTDCQdZxv4BeL/nY47D+yfK62fHWbTuBTFgck8fJtVJYmwqRo+tZpp7K95jD2DqqeoCHK7
	eAWR/Z9y+VrwUCeaszGfl+R/5NL9oHs/5iUf1/2OM5cL7UCxR8WSIIzZp4WjWukJIcpNjZekhk6xW
	aqlb1aAEKOjU6TZ/64CyjtcSeLhPWE8QibB6CppDf8ny9Zg3598R2TuyhEbwKQUTwIit3X/vhPZjT
	KDbbSylpSpjnfdJO75cQ==;
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 06 Jan 2026 20:57:07 +0100
From: wolf@yoxt.cc
To: linux-ide@vger.kernel.org
Cc: damien.lemoal@opensource.wdc.com, tj@kernel.org
Subject: [REGRESSION] libata: SATA LPM forcibly disabled on Intel Raptor Lake
 since Linux 6.14.
Message-ID: <605b34a7723436284699c9a8e524907b@yoxt.cc>
X-Sender: wolf@yoxt.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: wolf@yoxt.cc

Hello,

I am reporting a power-management regression in libata affecting the 
Intel Raptor Lake SATA AHCI Controller, introduced after Linux 6.14.

Hardware:
- CPU: Intel Core i5-12500
- SATA controller: Intel Corporation Raptor Lake SATA AHCI Controller 
[8086:7a62]
- Motherboard: Gigabyte B760 GAMING X DDR4

Distributions tested:
- Proxmox / Debian 13 (Trixie)
- Chimera Linux Live USB (kernel 6.18)

Kernel versions tested:
- 6.14.x (Proxmox): OK
- 6.17.x (Proxmox): REGRESSION
- 6.18.x (Chimera): REGRESSION

Problem description:
On kernel versions newer than 6.14, SATA Link Power Management (LPM) is 
forcibly disabled on part of the controller.
Out of 8 SCSI hosts, 4 hosts are stuck with link_power_management_policy 
set to "max_performance" and cannot be changed:

max_performance
max_performance
max_performance
max_performance
med_power_with_dipm
med_power_with_dipm
med_power_with_dipm
med_power_with_dipm

The motherboard only has 4 physical SATA ports, so the presence of 8 
hosts and 4 apparent dummy ports might be unexpected?

Manually setting LPM on the affected hosts fails with:
echo med_power_with_dipm > 
/sys/class/scsi_host/host*/link_power_management_policy
-bash: echo: write error: Operation not supported

This worked correctly on 6.14.x and earlier.

Because LPM cannot be enabled on all ports, the system is unable to 
enter deeper package C-states.

Observed effects:
- CPU package C-states are stuck at C3 (normally reaches C8 or deeper)
- Idle power consumption increased by approximately 4 watts
- powertop reports 4 out of 8 SATA LPM tunables as permanently "Bad"

SATA LPM worked reliably on this hardware on previous kernels

dmesg logs:
Working (6.14):
https://www.dropbox.com/scl/fi/5ryfjrp9fgx1dkxmszm5l/6.14-proxmox.txt?rlkey=75y3hue5whdmxbfvxq1piyofg&raw=1

Not working:
6.17 (Proxmox):
https://www.dropbox.com/scl/fi/ja2w0qtfummkmh406rxc7/6.17-proxmox.txt?rlkey=qxqpi7w2rn0ecbhdf2t4ju9kh&raw=1

6.18 (Chimera):
https://www.dropbox.com/scl/fi/s7412dfcv3pjk63mqfrep/6.18-chimera.txt?rlkey=9dd5wylsxb45l1b9zxgxadaw7&raw=1

While reviewing the logs, I noticed:
The presence of 4 apparent dummy SATA ports
Exactly 4 out of 8 SATA LPM entries disabled in both sysfs and powertop
This suggests the issue may be related to SATA port enumeration or 
libata power-management handling in newer kernels.


Expected behavior:
The ability to enable SATA Link Power Management on all SATA hosts 
should be restored, allowing the system to enter deeper package C-states 
and return to previous idle power levels.


Best regards,
Wolf
