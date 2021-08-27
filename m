Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FC2C432BE
	for <linux-ide@archiver.kernel.org>; Fri, 27 Aug 2021 12:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2994B60ED5
	for <linux-ide@archiver.kernel.org>; Fri, 27 Aug 2021 12:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245031AbhH0M1Y (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 27 Aug 2021 08:27:24 -0400
Received: from mout.gmx.com ([74.208.4.201]:37059 "EHLO mout.gmx.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231260AbhH0M1X (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 27 Aug 2021 08:27:23 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Aug 2021 08:27:23 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.com;
        s=dbd5af2cbaf7; t=1630067194;
        bh=boA9ttBV13kAYmPbvgyGZwdAkPScGDp5v+LFpboaCWQ=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=XP6imK+Q4Y662OOSewamFnM/KcwFUBf9uAr+V2GPxb9Irftk7mPNPHlN3UlBU8rJD
         VbSVUQykjqOhokfeHiOvJ1RwVJ6fOUrfkDx4AihXRZwltkjmdk01wg/B6kdvOQ9BQi
         3yCe7taNlr1r7QxacxzILbrHrai2hyVf/cErzDYY=
X-UI-Sender-Class: 214d933f-fd2f-45c7-a636-f5d79ae31a79
Received: from [2.124.18.161] ([2.124.18.161]) by web-mail.mail.com
 (3c-app-mailcom-lxa12.server.lan [10.76.45.13]) (via HTTP); Fri, 27 Aug
 2021 14:21:33 +0200
MIME-Version: 1.0
Message-ID: <trinity-a03ecf2a-166f-4889-99d1-fa2e31e12fe9-1630066893472@3c-app-mailcom-lxa12>
From:   Mark K <mark_k@iname.com>
To:     linux-ide@vger.kernel.org
Subject: SATA SSD inaccessible, fails on initial end-of-drive read command
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 27 Aug 2021 14:21:33 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:0LXfHGEXz/gk4/gmvpnNFqRleKtE23cm+l+h3Zk5UIgEhT4iO5iRwCJa/PKw9BtaHOHSO
 hWEj22VBtBG4/9khXe9ncp/C9cIC+UIPoNtnbFceqViIh5WNbMydjJmyhO20hcXGsx+P5iIGIkSN
 HU9FWxRPB8rEX6KSo+R1LhSjXbXOCfZEmPMN+rYkYWc7uX2bfA0EJM5k3aeFAmAIi+wB14xjhMXV
 SX4tYEVcqlFrTCa4WEBCdXt8MgBwwm1qJayvMsapFWBqLVghJzw3lFyxoZup9BBusMv38KZWGG+m
 NQ=
X-UI-Out-Filterresults: notjunk:1;V03:K0:a/ragNpXEto=:aVlbbFEHVKoCbZyW4XxZzl
 jAi5J2OUSy1L7ayYz3wOe2EpDxu8AEOMlhAazVA1KM51ThkLeQVjS82fmJx38I9lZhc/zGx6e
 tPyCoBoyrSKXLZYCwefTqUg/xSqCUSw/i6JT6ZG3xzId+gt3CHpnRZX1SJK/pGDNObqGVVcFX
 EZ5FEYgLqm6fNNVzbBGvts+R8rFWQMQ8BOqSU6s3Pbq9r0eYDwSC8mMkTbp76sL2hDodxlCrf
 lABF38qoXKU8HP7Prz+CxHhtzDmhMZKxLQ/CPaM+3/NGJXU2HziVgnUOtCT/dJSFRB5WGx9mJ
 ppnVQULwnr1TEP/C8epPxA7LaLINItvEMmS8BmYu4j22X42MfnS6kmlgHULPjOQlggSzT3TCM
 +Nm7GyxG0IHLEtTLiayvBPsm5WQ2SGc++A0r0EumMvOikuHRXsq+ITZ7j81HDfAZDbskISoyJ
 ZYSHZvQLGqG7KrGAyYEO6OOGkYetJMQsfCkrl+G2KK/TYofb1nubwF4fQkQq6Upf0WtBNrJJz
 wEq+4040nTNmOJAF6YzBUSj4PBmz5BcdMALtnDsWML6V0r8V0tv8uNoN2wWuRZXUiUaar0Q34
 Hq83VzpMcTVgr9RlJXNX1HDnHQb6xVPHg0KlVgzl8q7wlYEAiDZSkSlW15n+t8g7j11Fn5MeB
 vX+pc/km9Ry79yelhUjUCRjJ0gKbv/+eO0bD4NtHRN6xpcdpR9fvLSSC4fraYbdjgfM5KWba8
 GyWSVT1F4mkABma4Emba7j14WLdHjtY+AHPIR3xdnVyevUbYZDOO0ZSFDECoWCuQD07vrgC72
 Kx+4F8IH/6G2eUqmTMyxSHiKIBqnz/n1+/4rzd4mnW/eoJ8OiE=
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

I have a system with secondary SATA SSD (OCZ Saber 1000 480GB) which is
readable in Windows.

The drive capacity shown when probed by the kernel during boot is 937703088 =
0x37E436B0 sectors.

The drive seems to be failing the command issued by libata to read its last 8
sectors.

After reporting
  ata8.00: exception Emask 0x0 SAct 0x40 SErr 0x0 action 0x6 frozen
  ata8.00: failed command: READ FPDMA QUEUED
  ata8.00: cmd 60/08:30:a8:36:e4/00:00:37:00:00/40 tag 6 ncq dma 4096 in
it tries resetting the link several times and eventually gives up.

In this state, while the block device and sg device (/dev/sda and /dev/sg5) are
still present, any attempt to e.g. issue INQUIRY or READ CAPACITY fails, along
with data access commands like READ and WRITE, meaning the drive is
inaccessible in Linux.

I'm not sure whether the drive itself locks up after receiving that read
command, or whether libata is giving up too soon, or whether that error could
just be ignored.

Is there any way to tell libata to avoid issuing the initial end-of-drive read
command? Or is that read issued by the block layer?


[    1.499334] libata version 3.00 loaded.
[    1.505518] scsi host0: ata_generic
[    1.505703] scsi host2: ata_generic
[    1.516083] ata8: SATA max UDMA/133 abar m2048@0xf7f12000 port 0xf7f12180 irq 41
[    1.830511] ata8: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.830975] ata8.00: ATA-8: OCZ-SABER1000, 1.01, max UDMA/133
[    1.830978] ata8.00: 937703088 sectors, multi 1: LBA48 NCQ (depth 32), AA
[    1.836358] ata8.00: configured for UDMA/133
[   33.943503] ata8.00: exception Emask 0x0 SAct 0x40 SErr 0x0 action 0x6 frozen
[   33.943585] ata8.00: failed command: READ FPDMA QUEUED
[   33.943631] ata8.00: cmd 60/08:30:a8:36:e4/00:00:37:00:00/40 tag 6 ncq dma 4096 in
[   33.943735] ata8.00: status: { DRDY }
[   33.943768] ata8: hard resetting link
[   39.295447] ata8: link is slow to respond, please be patient (ready=0)
[   43.975468] ata8: COMRESET failed (errno=-16)
[   43.975531] ata8: hard resetting link
[   49.327467] ata8: link is slow to respond, please be patient (ready=0)
[   54.007448] ata8: COMRESET failed (errno=-16)
[   54.007512] ata8: hard resetting link
[   59.359466] ata8: link is slow to respond, please be patient (ready=0)
[   89.059463] ata8: COMRESET failed (errno=-16)
[   89.059532] ata8: limiting SATA link speed to 3.0 Gbps
[   89.059533] ata8: hard resetting link
[   94.111441] ata8: COMRESET failed (errno=-16)
[   94.111508] ata8: reset failed, giving up
[   94.111545] ata8.00: disabled
[   94.111668] ata8: EH complete


