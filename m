Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF4BC433E0
	for <linux-ide@archiver.kernel.org>; Mon, 22 Mar 2021 19:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F291619A1
	for <linux-ide@archiver.kernel.org>; Mon, 22 Mar 2021 19:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbhCVThE (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 22 Mar 2021 15:37:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53100 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231759AbhCVTgx (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 22 Mar 2021 15:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616441812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BQyilhVlKqwdiZesoi5DiXA0LcCIQd037taVJ3WNJWo=;
        b=C7yhoUr38gMuNAVl4uynxwgxt8RxUmkC1+odt7x3kamJQm83f9AM5sYC94ezYH4vkkTfs3
        h+ZZ3qllt7N8wLkkvH5Wkc3NDRVlmAVMjq8RKpvFWecB71e+Lom66wVhwE96GAUK3lu9Ji
        mZvxsv2Ucp6wcctK3dsyazKozvMQYUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-p9d2yxHwPjy8UVyfoe9E8A-1; Mon, 22 Mar 2021 15:36:50 -0400
X-MC-Unique: p9d2yxHwPjy8UVyfoe9E8A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 913B61922025
        for <linux-ide@vger.kernel.org>; Mon, 22 Mar 2021 19:36:49 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B41F31972B
        for <linux-ide@vger.kernel.org>; Mon, 22 Mar 2021 19:36:48 +0000 (UTC)
To:     linux-ide@vger.kernel.org
From:   Tomas Henzl <thenzl@redhat.com>
Subject: a problem with SATA hotswap
Message-ID: <aed5344b-97c2-7cac-fff7-6f2764e82f50@redhat.com>
Date:   Mon, 22 Mar 2021 20:36:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hi,

I'm seeing a problem with a SATA device hotplug. When the device is
reinserted after
blockdev --flushbufs /dev/sdb
echo 1 > /sys/block/sdb/device/delete
it comes up at the original speed. When there is a surprise removal and
the device is later reinserted it comes up with a slower speed (see log
below). The device is attached to a C620 Chipset.

Thank you for any ideas where to look or how to fix it.
I don't have direct access to the server so debugging is limited.

Thanks,
Tomas


[  194.519970] ata7: exception Emask 0x50 SAct 0x0 SErr 0x4090800 action
0xe frozen
[  194.520663] ata7: irq_stat 0x00400040, connection status changed
[  194.521356] ata7: SError: { HostInt PHYRdyChg 10B8B DevExch }
[  194.522052] ata7: hard resetting link
[  195.244974] ata7: SATA link down (SStatus 0 SControl 300)
[  199.316590] ata7: hard resetting link
[  201.250923] ata7: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[  201.254901] ata7.00: configured for UDMA/133
[  201.254904] ata7: EH complete
[  201.266766] ata7.00: Enabling discard_zeroes_data
[  220.776302] ata7: exception Emask 0x50 SAct 0x0 SErr 0x4090800 action
0xe frozen
[  220.777151] ata7: irq_stat 0x00400040, connection status changed
[  220.777997] ata7: SError: { HostInt PHYRdyChg 10B8B DevExch }
[  220.778841] ata7: hard resetting link
[  221.502286] ata7: SATA link down (SStatus 0 SControl 300)
[  222.852653] ata7: hard resetting link
[  224.177065] ata7: SATA link down (SStatus 0 SControl 300)
[  224.177070] ata7.00: link offline, clearing class 1 to NONE
[  226.115794] ata7: hard resetting link
[  227.185997] ata7: SATA link down (SStatus 0 SControl 300)
[  227.186002] ata7.00: link offline, clearing class 1 to NONE
[  227.186004] ata7.00: disabled
[  227.186011] ata7: EH complete
[  227.186016] ata7.00: detaching (SCSI 6:0:0:0)
[  227.186495] sd 6:0:0:0: [sdb] Synchronizing SCSI cache
[  227.186515] sd 6:0:0:0: [sdb] Synchronize Cache(10) failed: Result:
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  227.186517] sd 6:0:0:0: [sdb] Stopping disk
[  227.186522] sd 6:0:0:0: [sdb] Start/Stop Unit failed: Result:
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  228.310974] ata7: exception Emask 0x10 SAct 0x0 SErr 0x4050002 action
0xe frozen
[  228.311880] ata7: irq_stat 0x00000040, connection status changed
[  228.312773] ata7: SError: { RecovComm PHYRdyChg CommWake DevExch }
[  228.313661] ata7: hard resetting link
[  229.393811] ata7: SATA link down (SStatus 0 SControl 300)
[  229.393816] ata7.00: link offline, clearing class 1 to NONE
[  229.393821] ata7: EH complete
[  231.143689] ata7: exception Emask 0x10 SAct 0x0 SErr 0x4040000 action
0xe frozen
[  231.144575] ata7: irq_stat 0x00000040, connection status changed
[  231.145449] ata7: SError: { CommWake DevExch }
[  231.153398] ata7: limiting SATA link speed to 1.5 Gbps
[  231.153401] ata7: hard resetting link
[  232.184250] ata7: SATA link down (SStatus 0 SControl 310)
[  232.184254] ata7.00: link offline, clearing class 1 to NONE
[  232.184259] ata7: EH complete
[  233.557602] ata7: exception Emask 0x10 SAct 0x0 SErr 0x4040000 action
0xe frozen
[  233.558450] ata7: irq_stat 0x00000040, connection status changed
[  233.559292] ata7: SError: { CommWake DevExch }
[  233.564410] ata7: hard resetting link
[  234.799106] ata7: SATA link down (SStatus 0 SControl 300)
[  234.799111] ata7.00: link offline, clearing class 1 to NONE
[  234.799116] ata7: EH complete
[  236.100108] ata7: exception Emask 0x10 SAct 0x0 SErr 0x4050002 action
0xe frozen
[  236.100952] ata7: irq_stat 0x00000040, connection status changed
[  236.101776] ata7: SError: { RecovComm PHYRdyChg CommWake DevExch }
[  236.109050] ata7: limiting SATA link speed to 1.5 Gbps
[  236.109053] ata7: hard resetting link
[  238.055461] ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  238.055656] ata7.00: ATA-9: INTEL SSDSC2BB480G4, D2010370, max UDMA/133
[  238.055658] ata7.00: 937703088 sectors, multi 1: LBA48 NCQ (depth 31/32)
[  238.055902] ata7.00: configured for UDMA/133
[  238.055905] ata7: EH complete
[  238.055978] scsi 6:0:0:0: Direct-Access     ATA      INTEL SSDSC2BB48
0370 PQ: 0 ANSI: 5
[  238.066444] ata7.00: Enabling discard_zeroes_data
[  238.066462] sd 6:0:0:0: [sdb] 937703088 512-byte logical blocks: (480
GB/447 GiB)
[  238.066465] sd 6:0:0:0: [sdb] 4096-byte physical blocks
[  238.066492] sd 6:0:0:0: Attached scsi generic sg1 type 0
[  238.066587] sd 6:0:0:0: [sdb] Write Protect is off
[  238.066590] sd 6:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  238.066623] sd 6:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[  238.066739] ata7.00: Enabling discard_zeroes_data
[  238.068337]  sdb: sdb1 sdb2 sdb3
[  238.069073] ata7.00: Enabling discard_zeroes_data
[  238.069180] sd 6:0:0:0: [sdb] Attached SCSI disk
[  238.665551] ata7: exception Emask 0x10 SAct 0x0 SErr 0x4090000 action
0xe frozen
[  238.666351] ata7: irq_stat 0x00400040, connection status changed
[  238.667130] ata7: SError: { PHYRdyChg 10B8B DevExch }
[  238.667910] ata7: hard resetting link
[  239.391259] ata7: SATA link down (SStatus 0 SControl 310)
[  240.133570] ata7: hard resetting link
[  241.660985] ata7: SATA link down (SStatus 0 SControl 310)
[  241.660989] ata7.00: link offline, clearing class 1 to NONE
[  243.382389] ata7: hard resetting link
[  244.298795] ata7: SATA link down (SStatus 0 SControl 310)
[  244.298800] ata7.00: link offline, clearing class 1 to NONE
[  244.298803] ata7.00: disabled
[  244.298810] ata7: EH complete
[  244.298816] ata7.00: detaching (SCSI 6:0:0:0)
[  244.299619] sd 6:0:0:0: [sdb] Synchronizing SCSI cache
[  244.299643] sd 6:0:0:0: [sdb] Synchronize Cache(10) failed: Result:
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  244.299645] sd 6:0:0:0: [sdb] Stopping disk
[  244.299650] sd 6:0:0:0: [sdb] Start/Stop Unit failed: Result:
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  245.872026] ata7: exception Emask 0x10 SAct 0x0 SErr 0x4040000 action
0xe frozen
[  245.872817] ata7: irq_stat 0x00000040, connection status changed
[  245.873601] ata7: SError: { CommWake DevExch }
[  245.874364] ata7: hard resetting link
[  246.904672] ata7: SATA link down (SStatus 0 SControl 300)
[  246.904676] ata7.00: link offline, clearing class 1 to NONE
[  246.904681] ata7: EH complete
[  248.286662] ata7: exception Emask 0x10 SAct 0x0 SErr 0x4050002 action
0xe frozen
[  248.287433] ata7: irq_stat 0x00000040, connection status changed
[  248.288189] ata7: SError: { RecovComm PHYRdyChg CommWake DevExch }
[  248.295159] ata7: limiting SATA link speed to 1.5 Gbps
[  248.295161] ata7: hard resetting link
[  249.580383] ata7: SATA link down (SStatus 0 SControl 310)
[  249.580388] ata7.00: link offline, clearing class 1 to NONE
[  249.580393] ata7: EH complete
[  250.916625] ata7: exception Emask 0x10 SAct 0x0 SErr 0x4040000 action
0xe frozen
[  250.917386] ata7: irq_stat 0x00000040, connection status changed
[  250.918143] ata7: SError: { CommWake DevExch }
[  250.922709] ata7: hard resetting link
[  252.309973] ata7: SATA link down (SStatus 0 SControl 300)
[  252.309977] ata7.00: link offline, clearing class 1 to NONE
[  252.309981] ata7: EH complete
[  253.535746] ata7: exception Emask 0x10 SAct 0x0 SErr 0x4000000 action
0xe frozen
[  253.536511] ata7: irq_stat 0x00000040, connection status changed
[  253.537269] ata7: SError: { DevExch }
[  253.544205] ata7: limiting SATA link speed to 1.5 Gbps
[  253.544208] ata7: hard resetting link
[  254.981690] ata7: SATA link down (SStatus 0 SControl 310)
[  254.981694] ata7.00: link offline, clearing class 1 to NONE
[  254.981699] ata7: EH complete
[  256.399769] ata7: exception Emask 0x10 SAct 0x0 SErr 0x4040000 action
0xe frozen
[  256.400555] ata7: irq_stat 0x00000040, connection status changed
[  256.401327] ata7: SError: { CommWake DevExch }
[  256.406012] ata7: hard resetting link
[  257.538686] ata7: SATA link down (SStatus 0 SControl 300)
[  257.538690] ata7.00: link offline, clearing class 1 to NONE
[  257.538694] ata7: EH complete
[  258.896096] ata7: exception Emask 0x10 SAct 0x0 SErr 0x4050002 action
0xe frozen
[  258.896896] ata7: irq_stat 0x00000040, connection status changed
[  258.897685] ata7: SError: { RecovComm PHYRdyChg CommWake DevExch }
[  258.904689] ata7: limiting SATA link speed to 1.5 Gbps
[  258.904692] ata7: hard resetting link
[  260.545618] ata7: SATA link down (SStatus 0 SControl 310)
[  260.545622] ata7.00: link offline, clearing class 1 to NONE
[  260.545626] ata7: EH complete
[  261.853727] ata7: exception Emask 0x10 SAct 0x0 SErr 0x4040000 action
0xe frozen
[  261.854527] ata7: irq_stat 0x00000040, connection status changed
[  261.855309] ata7: SError: { CommWake DevExch }
[  261.860021] ata7: hard resetting link
[  263.399918] ata7: SATA link down (SStatus 0 SControl 300)
[  263.399923] ata7.00: link offline, clearing class 1 to NONE
[  263.399927] ata7: EH complete
[  264.873032] ata7: exception Emask 0x10 SAct 0x0 SErr 0x4050002 action
0xe frozen
[  264.873833] ata7: irq_stat 0x00000040, connection status changed
[  264.874621] ata7: SError: { RecovComm PHYRdyChg CommWake DevExch }
[  264.881612] ata7: limiting SATA link speed to 1.5 Gbps
[  264.881615] ata7: hard resetting link
[  266.166419] ata7: SATA link down (SStatus 0 SControl 310)
[  266.166423] ata7.00: link offline, clearing class 1 to NONE
[  266.166427] ata7: EH complete
[  267.544161] ata7: exception Emask 0x10 SAct 0x0 SErr 0x4040000 action
0xe frozen
[  267.544953] ata7: irq_stat 0x00000040, connection status changed
[  267.545745] ata7: SError: { CommWake DevExch }
[  267.550459] ata7: hard resetting link
[  268.887021] ata7: SATA link down (SStatus 0 SControl 300)
[  268.887025] ata7.00: link offline, clearing class 1 to NONE
[  268.887030] ata7: EH complete
[  270.173644] ata7: exception Emask 0x10 SAct 0x0 SErr 0x4050002 action
0xe frozen
[  270.174445] ata7: irq_stat 0x00000040, connection status changed
[  270.175234] ata7: SError: { RecovComm PHYRdyChg CommWake DevExch }
[  270.182240] ata7: limiting SATA link speed to 1.5 Gbps
[  270.182243] ata7: hard resetting link
[  271.569718] ata7: SATA link down (SStatus 0 SControl 310)
[  271.569722] ata7.00: link offline, clearing class 1 to NONE
[  271.569726] ata7: EH complete
[  272.931840] ata7: exception Emask 0x10 SAct 0x0 SErr 0x4040000 action
0xe frozen
[  272.932646] ata7: irq_stat 0x00000040, connection status changed
[  272.933435] ata7: SError: { CommWake DevExch }
[  272.938149] ata7: hard resetting link
[  274.172609] ata7: SATA link down (SStatus 0 SControl 300)
[  274.172614] ata7.00: link offline, clearing class 1 to NONE
[  274.172618] ata7: EH complete
[  275.412770] ata7: exception Emask 0x10 SAct 0x0 SErr 0x4040000 action
0xe frozen
[  275.413573] ata7: irq_stat 0x00000040, connection status changed
[  275.414358] ata7: SError: { CommWake DevExch }
[  275.421371] ata7: limiting SATA link speed to 1.5 Gbps
[  275.421374] ata7: hard resetting link
[  276.910171] ata7: SATA link down (SStatus 0 SControl 310)
[  276.910175] ata7.00: link offline, clearing class 1 to NONE
[  276.910180] ata7: EH complete
[  278.302891] ata7: exception Emask 0x10 SAct 0x0 SErr 0x4040000 action
0xe frozen
[  278.303687] ata7: irq_stat 0x00000040, connection status changed
[  278.304482] ata7: SError: { CommWake DevExch }
[  278.309210] ata7: hard resetting link
[  279.594864] ata7: SATA link down (SStatus 0 SControl 300)
[  279.594868] ata7.00: link offline, clearing class 1 to NONE
[  279.594872] ata7: EH complete
[  280.690799] ata7: exception Emask 0x10 SAct 0x0 SErr 0x4050002 action
0xe frozen
[  280.691601] ata7: irq_stat 0x00000040, connection status changed
[  280.692392] ata7: SError: { RecovComm PHYRdyChg CommWake DevExch }
[  280.699419] ata7: limiting SATA link speed to 1.5 Gbps
[  280.699422] ata7: hard resetting link
[  282.645697] ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  282.645916] ata7.00: ATA-9: INTEL SSDSC2BB480G4, D2010370, max UDMA/133
[  282.645918] ata7.00: 937703088 sectors, multi 1: LBA48 NCQ (depth 31/32)
[  282.646152] ata7.00: configured for UDMA/133
[  282.646156] ata7: EH complete
[  282.646231] scsi 6:0:0:0: Direct-Access     ATA      INTEL SSDSC2BB48
0370 PQ: 0 ANSI: 5
[  282.656680] ata7.00: Enabling discard_zeroes_data
[  282.656699] sd 6:0:0:0: [sdb] 937703088 512-byte logical blocks: (480
GB/447 GiB)
[  282.656703] sd 6:0:0:0: [sdb] 4096-byte physical blocks
[  282.656728] sd 6:0:0:0: Attached scsi generic sg1 type 0
[  282.656820] sd 6:0:0:0: [sdb] Write Protect is off
[  282.656823] sd 6:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  282.656862] sd 6:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[  282.657049] ata7.00: Enabling discard_zeroes_data
[  282.658660]  sdb: sdb1 sdb2 sdb3
[  282.658903] ata7.00: Enabling discard_zeroes_data
[  282.659010] sd 6:0:0:0: [sdb] Attached SCSI disk
[  284.269459] ata7: exception Emask 0x10 SAct 0x0 SErr 0x4090000 action
0xe frozen
[  284.270275] ata7: irq_stat 0x00400040, connection status changed
[  284.271069] ata7: SError: { PHYRdyChg 10B8B DevExch }
[  284.271865] ata7: hard resetting link
[  284.995119] ata7: SATA link down (SStatus 0 SControl 310)
[  285.537987] ata7: hard resetting link
[  286.861792] ata7: SATA link down (SStatus 0 SControl 310)
[  286.861797] ata7.00: link offline, clearing class 1 to NONE
[  288.167043] ata7: hard resetting link
[  289.439739] ata7: SATA link down (SStatus 0 SControl 310)
[  289.439743] ata7.00: link offline, clearing class 1 to NONE
[  289.439746] ata7.00: disabled
[  289.439754] ata7: EH complete
[  289.439760] ata7.00: detaching (SCSI 6:0:0:0)
[  289.440261] sd 6:0:0:0: [sdb] Synchronizing SCSI cache
[  289.440282] sd 6:0:0:0: [sdb] Synchronize Cache(10) failed: Result:
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  289.440284] sd 6:0:0:0: [sdb] Stopping disk
[  289.440289] sd 6:0:0:0: [sdb] Start/Stop Unit failed: Result:
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[  290.792231] ata7: exception Emask 0x10 SAct 0x0 SErr 0x4040000 action
0xe frozen
[  290.793020] ata7: irq_stat 0x00000040, connection status changed
[  290.793802] ata7: SError: { CommWake DevExch }
[  290.794568] ata7: hard resetting link
[  291.926899] ata7: SATA link down (SStatus 0 SControl 300)
[  291.926904] ata7.00: link offline, clearing class 1 to NONE
[  291.926908] ata7: EH complete
[  293.520213] ata7: exception Emask 0x10 SAct 0x0 SErr 0x4050002 action
0xe frozen
[  293.520972] ata7: irq_stat 0x00000040, connection status changed
[  293.521740] ata7: SError: { RecovComm PHYRdyChg CommWake DevExch }
[  293.528699] ata7: limiting SATA link speed to 1.5 Gbps
[  293.528702] ata7: hard resetting link
[  294.712348] ata7: SATA link down (SStatus 0 SControl 310)
[  294.712352] ata7.00: link offline, clearing class 1 to NONE
[  294.712356] ata7: EH complete
[  296.006140] ata7: exception Emask 0x10 SAct 0x0 SErr 0x4040000 action
0xe frozen
[  296.006905] ata7: irq_stat 0x00000040, connection status changed
[  296.007660] ata7: SError: { CommWake DevExch }
[  296.012248] ata7: hard resetting link
[  297.042873] ata7: SATA link down (SStatus 0 SControl 300)
[  297.042878] ata7.00: link offline, clearing class 1 to NONE
[  297.042881] ata7: EH complete
[  298.477590] ata7: exception Emask 0x10 SAct 0x0 SErr 0x4050002 action
0xe frozen
[  298.478354] ata7: irq_stat 0x00000040, connection status changed
[  298.479123] ata7: SError: { RecovComm PHYRdyChg CommWake DevExch }
[  298.486083] ata7: limiting SATA link speed to 1.5 Gbps
[  298.486087] ata7: hard resetting link
[  299.822343] ata7: SATA link down (SStatus 0 SControl 310)
[  299.822347] ata7.00: link offline, clearing class 1 to NONE
[  299.822351] ata7: EH complete
[  301.368439] ata7: exception Emask 0x10 SAct 0x0 SErr 0x4040000 action
0xe frozen
[  301.369218] ata7: irq_stat 0x00000040, connection status changed
[  301.369986] ata7: SError: { CommWake DevExch }
[  301.374670] ata7: hard resetting link
[  302.659677] ata7: SATA link down (SStatus 0 SControl 300)
[  302.659682] ata7.00: link offline, clearing class 1 to NONE
[  302.659686] ata7: EH complete
[  304.108936] ata7: exception Emask 0x10 SAct 0x0 SErr 0x4050002 action
0xe frozen
[  304.109733] ata7: irq_stat 0x00000040, connection status changed
[  304.110521] ata7: SError: { RecovComm PHYRdyChg CommWake DevExch }
[  304.117524] ata7: limiting SATA link speed to 1.5 Gbps
[  304.117527] ata7: hard resetting link
[  306.064678] ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  306.064862] ata7.00: ATA-9: INTEL SSDSC2BB480G4, D2010370, max UDMA/133
[  306.064865] ata7.00: 937703088 sectors, multi 1: LBA48 NCQ (depth 31/32)
[  306.065127] ata7.00: configured for UDMA/133
[  306.065131] ata7: EH complete
[  306.065203] scsi 6:0:0:0: Direct-Access     ATA      INTEL SSDSC2BB48
0370 PQ: 0 ANSI: 5
[  306.075661] ata7.00: Enabling discard_zeroes_data
[  306.075681] sd 6:0:0:0: [sdb] 937703088 512-byte logical blocks: (480
GB/447 GiB)
[  306.075684] sd 6:0:0:0: [sdb] 4096-byte physical blocks
[  306.075701] sd 6:0:0:0: Attached scsi generic sg1 type 0
[  306.075799] sd 6:0:0:0: [sdb] Write Protect is off
[  306.075802] sd 6:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  306.075834] sd 6:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[  306.075953] ata7.00: Enabling discard_zeroes_data
[  306.077922]  sdb: sdb1 sdb2 sdb3
[  306.078576] ata7.00: Enabling discard_zeroes_data
[  306.078699] sd 6:0:0:0: [sdb] Attached SCSI disk

