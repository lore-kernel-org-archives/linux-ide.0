Return-Path: <SRS0=Oljn=EK=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8F4C2D0A3
	for <linux-ide@archiver.kernel.org>; Wed,  4 Nov 2020 10:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17DAC207BB
	for <linux-ide@archiver.kernel.org>; Wed,  4 Nov 2020 10:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEKTFHG5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgKDKGZ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 4 Nov 2020 05:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgKDKGZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 4 Nov 2020 05:06:25 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA41C0613D3
        for <linux-ide@vger.kernel.org>; Wed,  4 Nov 2020 02:06:24 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id r9so21615491ioo.7
        for <linux-ide@vger.kernel.org>; Wed, 04 Nov 2020 02:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=QAzmKD/KL9lLJWbEU2h+TuELpjYFjjcQoXkre/kpTzo=;
        b=mEKTFHG5p5EOrYxUvCVvzcI8WCdhdfqujdKq4jgdI5xXK+IWOBurM5A9Ko9ziI1wtK
         PvPHyq2iwOIng+N/n5RLqyTOWt3TkiZkEXG7vIoAJdNnQ+gFu0+1As4AXwO+SJLDuiHr
         lIupbUKIh0o+/hvDkeJyNYRe4QBAHjiSX6FFe1j5JkFU9P27g0fJ8V2QW1xBiNBRK+Ds
         AsAwYar9l6siPGMs7dnGmONBIZYeQXM7BCeJJ6mZcM5hVwC2w0dE/R4VYHBW6H8OmDmY
         ZS4RhVlcoatDpSn0OCTPR5sFKUWrifyJR7+eaqefv0uQb42Y83WqT9XD7993opKNOOuH
         mkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=QAzmKD/KL9lLJWbEU2h+TuELpjYFjjcQoXkre/kpTzo=;
        b=MY0OX2EzNxWpfaGXDs9e/7XbaXgTfFH+qz4jNO/h2PRjSIYc4uTJsTMeZXz4/GnpS0
         C4Iki6+PwF67KMIdmbHlbxxjcKKcO3LyqpWgD/cnFwk3oloR7nmJM+cM9qT7roPi/WvT
         atzGXt6OpcgOcTTig84KbGlj4pP4RdKInzG4dBLiVLbij3F3ac7En1t3eBCTzPgE4ei5
         AsE05V7Z6c1NX+ytgLg03bPv5DAzOok8KC4pSdEuVwopH4vzRPRakmnf4lVl/tNvqhAf
         TsPAAxxwN9Lu121MSBBZxFBPlfIcFjCC4yp+neMV6JQ2gbRDumBvV91JQ6XKVJSm/t9L
         KO+g==
X-Gm-Message-State: AOAM530USWKJjw8YGSnBnhHt8AEQ5jKqYIDGYcFZzbOZ+amUAMZZiOj9
        8QAx9jKJAfPuK2dKsQOLBnzl4t1Ith2cJB1ki1E=
X-Google-Smtp-Source: ABdhPJxGpcS46yvvDENgRPaP9hfJvs7Ecvdf+RqzM8IUYLIq7WZgzVZiZCotRLeWhxb2A/1gk+WnUhAYLHy7vIe6nq4=
X-Received: by 2002:a6b:148e:: with SMTP id 136mr17311716iou.60.1604484384189;
 Wed, 04 Nov 2020 02:06:24 -0800 (PST)
MIME-Version: 1.0
From:   Sam Sankoorikal <sam.ks.2000@gmail.com>
Date:   Wed, 4 Nov 2020 15:36:08 +0530
Message-ID: <CAAjC+DoQ12oB39y=G99PvQ9rWrWJRFmdw4ox4QHRsnOqTsFgRw@mail.gmail.com>
Subject: [Query] Help understanding logs from libata-eh.c
To:     tj@kernel.org, htejun@gmail.com
Cc:     linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Folks,

I'm trying to understand the following logs for my sata drive. These
logs are seen immediately after 'reboot -f'. This is not seen
everytime a reboot is performed. A power-cycle ensures that it is
boots up fine.
Please help explain the reason for the 'timeout'. Please suggest what
needs to be done to ensure that reboot succeeds without hitting this
error?

-x-

reboot -f

Failed to read reboot parameter file: No such file or directory

Rebooting.

[  929.916076] ata6.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x6 fr=
ozen

[  930.007059] ata6.00: failed command: READ FPDMA QUEUED

[  930.072375] ata6.00: cmd 60/20:00:00:08:00/00:00:00:00:00/40 tag 0
ncq dma 16384 in

[  930.072375]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)

[  930.264519] ata6.00: status: { DRDY }

[  930.312264] ata1.00: exception Emask 0x0 SAct 0x6fffffff SErr 0x0
action 0x6 frozen

[  930.409971] ata1.00: failed command: WRITE FPDMA QUEUED

[  930.476424] ata1.00: cmd 61/08:00:fc:d5:82/00:00:05:00:00/40 tag 0
ncq dma 4096 out

[  930.476424]          res 40/00:01:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)

[  930.668747] ata1.00: status: { DRDY }



=E2=80=A6

[  930.668747] ata1.00: status: { DRDY }

[  930.716506] ata1.00: failed command: WRITE FPDMA QUEUED

[  930.782810] ata1.00: cmd 61/08:08:8c:d9:82/00:00:05:00:00/40 tag 1
ncq dma 4096 out

[  930.782810]          res 40/00:01:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)

[  930.975100] ata1.00: status: { DRDY }

[  931.022813] ata1.00: failed command: WRITE FPDMA QUEUED

[  931.089110] ata1.00: cmd 61/08:10:e4:d9:82/00:00:05:00:00/40 tag 2
ncq dma 4096 out

[  931.089110]          res 40/00:01:00:4f:c2/00:00:00:00:00/00 Emask
0x4 (timeout)

[  931.281454] ata1.00: status: { DRDY }

[  931.329235] ata1.00: failed command: WRITE FPDMA QUEUED

[  931.395489] ata1.00: cmd 61/08:18:9c:da:82/00:00:05:00:00/40 tag 3
ncq dma 4096 out

[  931.395489]          res 40/00:01:09:4f:c2/00:00:00:00:00/00 Emask
0x4 (timeout)

[  931.587634] ata1.00: status: { DRDY }

[  931.635372] ata1.00: failed command: WRITE FPDMA QUEUED

[  931.701645] ata1.00: cmd 61/08:20:34:db:82/00:00:05:00:00/40 tag 4
ncq dma 4096 out

[  931.701645]          res 40/00:01:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)

[  931.893804] ata1.00: status: { DRDY }

[  931.941531] ata1.00: failed command: WRITE FPDMA QUEUED

[  932.007820] ata1.00: cmd 61/08:28:4c:e0:82/00:00:05:00:00/40 tag 5
ncq dma 4096 out

[  932.007820]          res 40/00:01:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)

[  932.199990] ata1.00: status: { DRDY }

[  932.247731] ata1.00: failed command: WRITE FPDMA QUEUED



=E2=80=A6



[  939.308610] ata1.00: failed command: WRITE FPDMA QUEUED

[  939.374853] ata1.00: cmd 61/08:f0:2c:d2:82/00:00:05:00:00/40 tag 30
ncq dma 4096 out

[  939.374853]          res 40/00:01:06:4f:c2/00:00:00:00:00/00 Emask
0x4 (timeout)

[  939.567957] ata1.00: status: { DRDY }

[  945.265210] ata6.00: revalidation failed (errno=3D-5)

[  945.327849] ata1.00: revalidation failed (errno=3D-5)

[  956.017398] ata1.00: revalidation failed (errno=3D-5)

[  956.080070] ata6.00: revalidation failed (errno=3D-5)

[  986.737616] ata6.00: revalidation failed (errno=3D-5)

[  986.800288] ata1.00: revalidation failed (errno=3D-5)

[  987.167188] blk_update_request: I/O error, dev sdb, sector 2048

[  987.167265] blk_update_request: I/O error, dev sda, sector 92459564



lspci -vvv | grep -i sata
00:1f.2 SATA controller: Intel Corporation C610/X99 series chipset
6-Port SATA Controller [AHCI mode] (rev 05) (prog-if 01 [AHCI 1.0])
        Subsystem: Intel Corporation C610/X99 series chipset 6-Port
SATA Controller [AHCI mode]
        Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=3D00000004
pcilib: sysfs_read_vpd: read failed: Input/output error

smartctl -a /dev/sda
smartctl 6.5 2016-05-07 r4318
[x86_64-linux-4.8.28-WR2.2.1_standard-gf2ab372] (local build)
Copyright (C) 2002-16, Bruce Allen, Christian Franke, www.smartmontools.org

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Device Model:     StorFly VSFBM8CC200G-JUN
Serial Number:    P1T14005214001280074
Firmware Version: 0202-000
User Capacity:    200,049,647,616 bytes [200 GB]
Sector Size:      512 bytes logical/physical
Rotation Rate:    Solid State Device
Device is:        Not in smartctl database [for details use: -P showall]
ATA Version is:   ACS-2 (minor revision not indicated)
SATA Version is:  SATA 3.1, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Wed Nov  4 01:59:20 2020 PST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x00) Offline data collection activity
                                        was never started.
                                        Auto Offline Data Collection: Disab=
led.
Self-test execution status:      (   0) The previous self-test routine comp=
leted
                                        without error or no self-test has e=
ver
                                        been run.
Total time to complete Offline
data collection:                (    0) seconds.
Offline data collection
capabilities:                    (0x71) SMART execute Offline immediate.
                                        No Auto Offline data collection sup=
port.
                                        Suspend Offline collection upon new
                                        command.
                                        No Offline surface scan supported.
                                        Self-test supported.
                                        Conveyance Self-test supported.
                                        Selective Self-test supported.
SMART capabilities:            (0x0002) Does not save SMART data before
                                        entering power-saving mode.
                                        Supports SMART auto save timer.
Error logging capability:        (0x01) Error logging supported.
                                        General Purpose Logging supported.
Short self-test routine
recommended polling time:        (   1) minutes.
Extended self-test routine
recommended polling time:        (   1) minutes.
Conveyance self-test routine
recommended polling time:        (   1) minutes.

SMART Attributes Data Structure revision number: 1
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x0000   100   100   070    Old_age
Offline      -       0
  5 Reallocated_Sector_Ct   0x0000   100   100   000    Old_age
Offline      -       0
  9 Power_On_Hours          0x0000   100   100   000    Old_age
Offline      -       240
 12 Power_Cycle_Count       0x0000   100   100   000    Old_age
Offline      -       88
160 Unknown_Attribute       0x0000   100   100   000    Old_age
Offline      -       0
161 Unknown_Attribute       0x0000   100   100   000    Old_age
Offline      -       537
163 Unknown_Attribute       0x0000   100   100   000    Old_age
Offline      -       49
164 Unknown_Attribute       0x0000   100   100   000    Old_age
Offline      -       249797
165 Unknown_Attribute       0x0000   100   100   000    Old_age
Offline      -       156
166 Unknown_Attribute       0x0000   100   100   000    Old_age
Offline      -       54
167 Unknown_Attribute       0x0000   100   100   000    Old_age
Offline      -       121
168 Unknown_Attribute       0x0000   100   100   000    Old_age
Offline      -       3000
177 Wear_Leveling_Count     0x0000   100   100   050    Old_age
Offline      -       114
178 Used_Rsvd_Blk_Cnt_Chip  0x0000   100   100   000    Old_age
Offline      -       0
181 Program_Fail_Cnt_Total  0x0000   100   100   000    Old_age
Offline      -       0
182 Erase_Fail_Count_Total  0x0000   100   100   000    Old_age
Offline      -       0
187 Reported_Uncorrect      0x0000   100   100   000    Old_age
Offline      -       0
192 Power-Off_Retract_Count 0x0000   100   100   000    Old_age
Offline      -       48
194 Temperature_Celsius     0x0000   100   100   000    Old_age
Offline      -       31
195 Hardware_ECC_Recovered  0x0000   100   100   000    Old_age
Offline      -       322712
196 Reallocated_Event_Count 0x0000   100   100   016    Old_age
Offline      -       0
198 Offline_Uncorrectable   0x0000   100   100   000    Old_age
Offline      -       0
199 UDMA_CRC_Error_Count    0x0000   100   100   050    Old_age
Offline      -       0
232 Available_Reservd_Space 0x0000   100   100   000    Old_age
Offline      -       100
241 Total_LBAs_Written      0x0000   100   100   000    Old_age
Offline      -       541894
242 Total_LBAs_Read         0x0000   100   100   000    Old_age
Offline      -       68407
248 Unknown_Attribute       0x0000   100   100   000    Old_age
Offline      -       96
249 Unknown_Attribute       0x0000   100   100   000    Old_age
Offline      -       100

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
No self-tests have been logged.  [To run self-tests, use: smartctl -t]

SMART Selective self-test log data structure revision number 1
 SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
    1        0        0  Not_testing
    2        0        0  Not_testing
    3        0        0  Not_testing
    4        0        0  Not_testing
    5        0        0  Not_testing
    6        0    65535  Read_scanning was never started
Selective self-test flags (0x0):
  After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.
-x-

Regards.
-sam
