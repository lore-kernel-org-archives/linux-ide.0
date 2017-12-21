From: Jason Yan <yanaijie@huawei.com>
Subject: Re: about warning in ata_eh_finish()
Date: Thu, 21 Dec 2017 09:31:20 +0800
Message-ID: <5A3B0EE8.2060707@huawei.com>
References: <5A39FF85.1040904@huawei.com>
 <20171220173636.GC3413940@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:34625 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756644AbdLUBcK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 20 Dec 2017 20:32:10 -0500
In-Reply-To: <20171220173636.GC3413940@devbig577.frc2.facebook.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Tejun,

On 2017/12/21 1:36, Tejun Heo wrote:
> Which kernel version are you running on what sort of device?  Can you
> post the full log?

We have tested kernel 4.12 to 4.15, all have this warning.
Some sas/sata disks directly connected to hisi sas controller.

The full log is as follows, please ignore the duplicated log because I 
didn't close the boot console.

--IPOP Time:12/3/2017_2:03:56--
[26578.886290] driverversion:v1.6.
[26578.886290] driverversion:v1.6.
[26578.897569] |core id|port id | phy id |phy mode | phy status | phy 
type | dev sas address  |dev info |
[26578.897569] |core id|port id | phy id |phy mode | phy status | phy 
type | dev sas address  |dev info |
[26578.925190] |      0|       0|       0|       0 |          0 | 
  2 |0x5001882016000000|        0|
[26578.925190] |      0|       0|       0|       0 |          0 | 
  2 |0x5001882016000000|        0|
[26578.951506] |dq_1b_ecc |iost_1b_ecc 
|tct_ram_ecc|dq_ram_ecc|iost_ram_ecc|itct_1b_ecc|axi incorrect|
[26578.951506] |dq_1b_ecc |iost_1b_ecc 
|tct_ram_ecc|dq_ram_ecc|iost_ram_ecc|itct_1b_ecc|axi incorrect|
[26578.976032] |        0 |           0|          0|         0| 
   0|          0|            0|
[26578.976032] |        0 |           0|          0|         0| 
   0|          0|            0|
[26579.000336] - - - - - - - - - - - - - -  - - - - - - - - - - - - - - 
- - -  - - -  - - - - - - - - - -
[26579.000336] - - - - - - - - - - - - - -  - - - - - - - - - - - - - - 
- - -  - - -  - - - - - - - - - -
[26579.025793] |core id|port id | phy id |phy mode | phy status | phy 
type | dev sas address  |dev info |
[26579.025793] |core id|port id | phy id |phy mode | phy status | phy 
type | dev sas address  |dev info |
[26579.051973] |      0|       1|       1|       0 |          0 | 
  2 |0x5001882016000000|        0|
[26579.051973] |      0|       1|       1|       0 |          0 | 
  2 |0x5001882016000000|        0|
[26579.077037] |dq_1b_ecc |iost_1b_ecc 
|tct_ram_ecc|dq_ram_ecc|iost_ram_ecc|itct_1b_ecc|axi incorrect|
[26579.077037] |dq_1b_ecc |iost_1b_ecc 
|tct_ram_ecc|dq_ram_ecc|iost_ram_ecc|itct_1b_ecc|axi incorrect|
[26579.101389] |        0 |           0|          0|         0| 
   0|          0|            0|
[26579.101389] |        0 |           0|          0|         0| 
   0|          0|            0|
[26579.125601] - - - - - - - - - - - - - -  - - - - - - - - - - - - - - 
- - -  - - -  - - - - - - - - - -
[26579.125601] - - - - - - - - - - - - - -  - - - - - - - - - - - - - - 
- - -  - - -  - - - - - - - - - -
[26579.150496] |core id|port id | phy id |phy mode | phy status | phy 
type | dev sas address  |dev info |
[26579.150496] |core id|port id | phy id |phy mode | phy status | phy 
type | dev sas address  |dev info |
[26579.175551] |      0|       2|       2|       0 |          0 | 
  1 |0x5001882016000000|        0|
[26579.175551] |      0|       2|       2|       0 |          0 | 
  1 |0x5001882016000000|        0|
[26579.200592] |dq_1b_ecc |iost_1b_ecc 
|tct_ram_ecc|dq_ram_ecc|iost_ram_ecc|itct_1b_ecc|axi incorrect|
[26579.200592] |dq_1b_ecc |iost_1b_ecc 
|tct_ram_ecc|dq_ram_ecc|iost_ram_ecc|itct_1b_ecc|axi incorrect|
[26579.224980] |        0 |           0|          0|         0| 
   0|          0|            0|
[26579.224980] |        0 |           0|          0|         0| 
   0|          0|            0|
[26579.249208] - - - - - - - - - - - - - -  - - - - - - - - - - - - - - 
- - -  - - -  - - - - - - - - - -
[26579.249208] - - - - - - - - - - - - - -  - - - - - - - - - - - - - - 
- - -  - - -  - - - - - - - - - -
[26579.274325] |core id|port id | phy id |phy mode | phy status | phy 
type | dev sas address  |dev info |
[26579.274325] |core id|port id | phy id |phy mode | phy status | phy 
type | dev sas address  |dev info |
[26579.299307] |      0|       3|       3|       0 |          0 | 
  1 |0x5001882016000000|        0|
[26579.299307] |      0|       3|       3|       0 |          0 | 
  1 |0x5001882016000000|        0|
[26579.324170] |dq_1b_ecc |iost_1b_ecc 
|tct_ram_ecc|dq_ram_ecc|iost_ram_ecc|itct_1b_ecc|axi incorrect|
[26579.324170] |dq_1b_ecc |iost_1b_ecc 
|tct_ram_ecc|dq_ram_ecc|iost_ram_ecc|itct_1b_ecc|axi incorrect|
[26579.348738] |        0 |           0|          0|         0| 
   0|          0|            0|
[26579.348738] |        0 |           0|          0|         0| 
   0|          0|            0|
[26579.372943] - - - - - - - - - - - - - -  - - - - - - - - - - - - - - 
- - -  - - -  - - - - - - - - - -
[26579.372943] - - - - - - - - - - - - - -  - - - - - - - - - - - - - - 
- - -  - - -  - - - - - - - - - -
[26579.397802] |core id|port id | phy id |phy mode | phy status | phy 
type | dev sas address  |dev info |
[26579.397802] |core id|port id | phy id |phy mode | phy status | phy 
type | dev sas address  |dev info |
[26579.423176] |      0|       4|       4|       0 |          0 | 
  2 |0x5001882016000000|        0|
[26579.423176] |      0|       4|       4|       0 |          0 | 
  2 |0x5001882016000000|        0|
[26579.448025] |dq_1b_ecc |iost_1b_ecc 
|tct_ram_ecc|dq_ram_ecc|iost_ram_ecc|itct_1b_ecc|axi incorrect|
[26579.448025] |dq_1b_ecc |iost_1b_ecc 
|tct_ram_ecc|dq_ram_ecc|iost_ram_ecc|itct_1b_ecc|axi incorrect|
[26579.472366] |        0 |           0|          0|         0| 
   0|          0|            0|
[26579.472366] |        0 |           0|          0|         0| 
   0|          0|            0|
[26579.496780] - - - - - - - - - - - - - -  - - - - - - - - - - - - - - 
- - -  - - -  - - - - - - - - - -
[26579.496780] - - - - - - - - - - - - - -  - - - - - - - - - - - - - - 
- - -  - - -  - - - - - - - - - -
[26579.521676] |core id|port id | phy id |phy mode | phy status | phy 
type | dev sas address  |dev info |
[26579.521676] |core id|port id | phy id |phy mode | phy status | phy 
type | dev sas address  |dev info |
[26579.546648] |      0|       5|       5|       0 |          0 | 
  2 |0x5001882016000000|        0|
[26579.546648] |      0|       5|       5|       0 |          0 | 
  2 |0x5001882016000000|        0|
[26579.571522] |dq_1b_ecc |iost_1b_ecc 
|tct_ram_ecc|dq_ram_ecc|iost_ram_ecc|itct_1b_ecc|axi incorrect|
[26579.571522] |dq_1b_ecc |iost_1b_ecc 
|tct_ram_ecc|dq_ram_ecc|iost_ram_ecc|itct_1b_ecc|axi incorrect|
[26579.595796] |        0 |           0|          0|         0| 
   0|          0|            0|
[26579.595796] |        0 |           0|          0|         0| 
   0|          0|            0|
[26579.620742] - - - - - - - - - - - - - -  - - - - - - - - - - - - - - 
- - -  - - -  - - - - - - - - - -
[26579.620742] - - - - - - - - - - - - - -  - - - - - - - - - - - - - - 
- - -  - - -  - - - - - - - - - -
[26579.646939] |core id|port id | phy id |phy mode | phy status | phy 
type | dev sas address  |dev info |
[26579.646939] |core id|port id | phy id |phy mode | phy status | phy 
type | dev sas address  |dev info |
[26579.671955] |      0|       6|       6|       0 |          0 | 
  2 |0x5001882016000000|        0|
[26579.671955] |      0|       6|       6|       0 |          0 | 
  2 |0x5001882016000000|        0|
[26579.696767] |dq_1b_ecc |iost_1b_ecc 
|tct_ram_ecc|dq_ram_ecc|iost_ram_ecc|itct_1b_ecc|axi incorrect|
[26579.696767] |dq_1b_ecc |iost_1b_ecc 
|tct_ram_ecc|dq_ram_ecc|iost_ram_ecc|itct_1b_ecc|axi incorrect|
[26579.722604] |        0 |           0|          0|         0| 
   0|          0|            0|
[26579.722604] |        0 |           0|          0|         0| 
   0|          0|            0|
[26579.746776] - - - - - - - - - - - - - -  - - - - - - - - - - - - - - 
- - -  - - -  - - - - - - - - - -
[26579.746776] - - - - - - - - - - - - - -  - - - - - - - - - - - - - - 
- - -  - - -  - - - - - - - - - -
[26579.771601] |core id|port id | phy id |phy mode | phy status | phy 
type | dev sas address  |dev info |
[26579.771601] |core id|port id | phy id |phy mode | phy status | phy 
type | dev sas address  |dev info |
[26579.796675] |      0|       7|       7|       0 |          0 | 
  2 |0x5001882016000000|        0|
[26579.796675] |      0|       7|       7|       0 |          0 | 
  2 |0x5001882016000000|        0|
[26579.821494] |dq_1b_ecc |iost_1b_ecc 
|tct_ram_ecc|dq_ram_ecc|iost_ram_ecc|itct_1b_ecc|axi incorrect|
[26579.821494] |dq_1b_ecc |iost_1b_ecc 
|tct_ram_ecc|dq_ram_ecc|iost_ram_ecc|itct_1b_ecc|axi incorrect|
[26579.845648] |        0 |           0|          0|         0| 
   0|          0|            0|
[26579.845648] |        0 |           0|          0|         0| 
   0|          0|            0|
[26579.870194] - - - - - - - - - - - - - -  - - - - - - - - - - - - - - 
- - -  - - -  - - - - - - - - - -
[26579.870194] - - - - - - - - - - - - - -  - - - - - - - - - - - - - - 
- - -  - - -  - - - - - - - - - -
[26579.895005] 
===================================================================================================
[26579.895005] 
===================================================================================================
[26579.922206] |core id|port id|phy id|phy nums|queue count|max phy 
nums|mini linkrate|max linkrate|nego linkrate|
[26579.922206] |core id|port id|phy id|phy nums|queue count|max phy 
nums|mini linkrate|max linkrate|nego linkrate|
[26579.949162] |      0|      0|     0|       8|         16| 
8|            8|          11|         1.5G|
[26579.949162] |      0|      0|     0|       8|         16| 
8|            8|          11|         1.5G|
[26579.976014] 
===================================================================================================
[26579.976014] 
===================================================================================================
[26580.002861] |core id|port id|phy id|phy nums|queue count|max phy 
nums|mini linkrate|max linkrate|nego linkrate|
[26580.002861] |core id|port id|phy id|phy nums|queue count|max phy 
nums|mini linkrate|max linkrate|nego linkrate|
[26580.029907] |      0|      1|     1|       8|         16| 
8|            8|          11|         1.5G|
[26580.029907] |      0|      1|     1|       8|         16| 
8|            8|          11|         1.5G|
[26580.057054] 
===================================================================================================
[26580.057054] 
===================================================================================================
[26580.083917] |core id|port id|phy id|phy nums|queue count|max phy 
nums|mini linkrate|max linkrate|nego linkrate|
[26580.083917] |core id|port id|phy id|phy nums|queue count|max phy 
nums|mini linkrate|max linkrate|nego linkrate|
[26580.110862] |      0|      2|     2|       8|         16| 
8|            8|          11|         1.5G|
[26580.110862] |      0|      2|     2|       8|         16| 
8|            8|          11|         1.5G|
[26580.137742] 
===================================================================================================
[26580.137742] 
===================================================================================================
[26580.164967] |core id|port id|phy id|phy nums|queue count|max phy 
nums|mini linkrate|max linkrate|nego linkrate|
[26580.164967] |core id|port id|phy id|phy nums|queue count|max phy 
nums|mini linkrate|max linkrate|nego linkrate|
[26580.191859] |      0|      3|     3|       8|         16| 
8|            8|          11|         1.5G|
[26580.191859] |      0|      3|     3|       8|         16| 
8|            8|          11|         1.5G|
[26580.218635] 
===================================================================================================
[26580.218635] 
===================================================================================================
[26580.245459] |core id|port id|phy id|phy nums|queue count|max phy 
nums|mini linkrate|max linkrate|nego linkrate|
[26580.245459] |core id|port id|phy id|phy nums|queue count|max phy 
nums|mini linkrate|max linkrate|nego linkrate|
[26580.272329] |      0|      4|     4|       8|         16| 
8|            8|          11|         1.5G|
[26580.272329] |      0|      4|     4|       8|         16| 
8|            8|          11|         1.5G|
[26580.299178] 
===================================================================================================
[26580.299178] 
===================================================================================================
[26580.326276] |core id|port id|phy id|phy nums|queue count|max phy 
nums|mini linkrate|max linkrate|nego linkrate|
[26580.326276] |core id|port id|phy id|phy nums|queue count|max phy 
nums|mini linkrate|max linkrate|nego linkrate|
[26580.353183] |      0|      5|     5|       8|         16| 
8|            8|          11|         1.5G|
[26580.353183] |      0|      5|     5|       8|         16| 
8|            8|          11|         1.5G|
[26580.379961] 
===================================================================================================
[26580.379961] 
===================================================================================================
[26580.406824] |core id|port id|phy id|phy nums|queue count|max phy 
nums|mini linkrate|max linkrate|nego linkrate|
[26580.406824] |core id|port id|phy id|phy nums|queue count|max phy 
nums|mini linkrate|max linkrate|nego linkrate|
[26580.433665] |      0|      6|     6|       8|         16| 
8|            8|          11|         1.5G|
[26580.433665] |      0|      6|     6|       8|         16| 
8|            8|          11|         1.5G|
[26580.460516] 
===================================================================================================
[26580.460516] 
===================================================================================================
[26580.487277] |core id|port id|phy id|phy nums|queue count|max phy 
nums|mini linkrate|max linkrate|nego linkrate|
[26580.487277] |core id|port id|phy id|phy nums|queue count|max phy 
nums|mini linkrate|max linkrate|nego linkrate|
[26580.514383] |      0|      7|     7|       8|         16| 
8|            8|          11|         1.5G|
[26580.514383] |      0|      7|     7|       8|         16| 
8|            8|          11|         1.5G|
[26625.414506] hisi_sas_v3_hw 0000:74:02.0: phydown: phy0 phy_state=0xfe
[26625.414506] hisi_sas_v3_hw 0000:74:02.0: phydown: phy0 phy_state=0xfe
[26625.930184] sd 2:0:46:0: [sda] Synchronizing SCSI cache
[26625.930184] sd 2:0:46:0: [sda] Synchronizing SCSI cache
[26626.029224] sd 2:0:46:0: [sda] Synchronize Cache(10) failed: Result: 
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[26626.029224] sd 2:0:46:0: [sda] Synchronize Cache(10) failed: Result: 
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[26626.379429] hisi_sas_v3_hw 0000:74:02.0: dev[0:1] is gone
[26626.379429] hisi_sas_v3_hw 0000:74:02.0: dev[0:1] is gone

--IPOP Time:12/3/2017_2:04:56--
[26636.989039] hisi_sas_v3_hw 0000:74:02.0: phyup: phy0 link_rate=8
[26636.989039] hisi_sas_v3_hw 0000:74:02.0: phyup: phy0 link_rate=8
[26637.107664] hisi_sas_v3_hw 0000:74:02.0: dev[0:1] found
[26637.107664] hisi_sas_v3_hw 0000:74:02.0: dev[0:1] found
[26637.480378] scsi 2:0:54:0: Direct-Access     HGST     HUC101818CS4200 
  A902 PQ: 0 ANSI: 6
[26637.480378] scsi 2:0:54:0: Direct-Access     HGST     HUC101818CS4200 
  A902 PQ: 0 ANSI: 6
[26638.259023] sd 2:0:54:0: [sda] 3516328368 512-byte logical blocks: 
(1.80 TB/1.64 TiB)
[26638.259023] sd 2:0:54:0: [sda] 3516328368 512-byte logical blocks: 
(1.80 TB/1.64 TiB)
[26638.284719] sd 2:0:54:0: [sda] 4096-byte physical blocks
[26638.284719] sd 2:0:54:0: [sda] 4096-byte physical blocks
[26638.343873] sd 2:0:54:0: [sda] Write Protect is off
[26638.343873] sd 2:0:54:0: [sda] Write Protect is off
[26638.526156] sd 2:0:54:0: [sda] Write cache: enabled, read cache: 
enabled, supports DPO and FUA
[26638.526156] sd 2:0:54:0: [sda] Write cache: enabled, read cache: 
enabled, supports DPO and FUA
[26640.229889] sd 2:0:54:0: [sda] Attached SCSI disk
[26640.229889] sd 2:0:54:0: [sda] Attached SCSI disk
[26648.873697] hisi_sas_v3_hw 0000:74:02.0: phydown: phy1 phy_state=0xfd
[26648.873697] hisi_sas_v3_hw 0000:74:02.0: phydown: phy1 phy_state=0xfd
[26649.219357] sd 2:0:47:0: [sdb] Synchronizing SCSI cache
[26649.219357] sd 2:0:47:0: [sdb] Synchronizing SCSI cache
[26649.286834] sd 2:0:47:0: [sdb] Synchronize Cache(10) failed: Result: 
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[26649.286834] sd 2:0:47:0: [sdb] Synchronize Cache(10) failed: Result: 
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[26649.724381] hisi_sas_v3_hw 0000:74:02.0: dev[1:1] is gone
[26649.724381] hisi_sas_v3_hw 0000:74:02.0: dev[1:1] is gone
[26660.708058] hisi_sas_v3_hw 0000:74:02.0: phyup: phy1 link_rate=8
[26660.708058] hisi_sas_v3_hw 0000:74:02.0: phyup: phy1 link_rate=8
[26660.820772] hisi_sas_v3_hw 0000:74:02.0: dev[1:1] found
[26660.820772] hisi_sas_v3_hw 0000:74:02.0: dev[1:1] found
[26661.157316] scsi 2:0:55:0: Direct-Access     SEAGATE  ST600MM0088 
   N003 PQ: 0 ANSI: 6
[26661.157316] scsi 2:0:55:0: Direct-Access     SEAGATE  ST600MM0088 
   N003 PQ: 0 ANSI: 6
[26662.261880] sd 2:0:55:0: [sdb] 1172123568 512-byte logical blocks: 
(600 GB/559 GiB)
[26662.261880] sd 2:0:55:0: [sdb] 1172123568 512-byte logical blocks: 
(600 GB/559 GiB)
[26662.340445] sd 2:0:55:0: [sdb] Write Protect is off
[26662.340445] sd 2:0:55:0: [sdb] Write Protect is off
[26662.497744] sd 2:0:55:0: [sdb] Write cache: enabled, read cache: 
enabled, supports DPO and FUA
[26662.497744] sd 2:0:55:0: [sdb] Write cache: enabled, read cache: 
enabled, supports DPO and FUA
[26663.814019] sd 2:0:55:0: [sdb] Attached SCSI disk
[26663.814019] sd 2:0:55:0: [sdb] Attached SCSI disk
[26672.036357] hisi_sas_v3_hw 0000:74:02.0: phydown: phy2 phy_state=0xfb
[26672.036357] hisi_sas_v3_hw 0000:74:02.0: phydown: phy2 phy_state=0xfb
[26672.284269] sd 2:0:48:0: [sdc] Synchronizing SCSI cache
[26672.284269] sd 2:0:48:0: [sdc] Synchronizing SCSI cache
[26672.320666] sd 2:0:48:0: [sdc] Synchronize Cache(10) failed: Result: 
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[26672.320666] sd 2:0:48:0: [sdc] Synchronize Cache(10) failed: Result: 
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[26672.351326] sd 2:0:48:0: [sdc] Stopping disk
[26672.351326] sd 2:0:48:0: [sdc] Stopping disk
[26672.371145] sd 2:0:48:0: [sdc] Start/Stop Unit failed: Result: 
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[26672.371145] sd 2:0:48:0: [sdc] Start/Stop Unit failed: Result: 
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK

--IPOP Time:12/3/2017_2:05:57--
[26703.586351] hisi_sas_v3_hw 0000:74:02.0: task prep: SATA/STP port2 
not attach device
[26703.586351] hisi_sas_v3_hw 0000:74:02.0: task prep: SATA/STP port2 
not attach device
[26703.607605] hisi_sas_v3_hw 0000:74:02.0: task exec: failed[138]!
[26703.607605] hisi_sas_v3_hw 0000:74:02.0: task exec: failed[138]!
[26703.627180] hisi_sas_v3_hw 0000:74:02.0: abort tmf: executing 
internal task failed: 138
[26703.627180] hisi_sas_v3_hw 0000:74:02.0: abort tmf: executing 
internal task failed: 138
[26703.649037] hisi_sas_v3_hw 0000:74:02.0: ata disk reset failed
[26703.649037] hisi_sas_v3_hw 0000:74:02.0: ata disk reset failed
[26703.666632] hisi_sas_v3_hw 0000:74:02.0: abort task: rc=138
[26703.666632] hisi_sas_v3_hw 0000:74:02.0: abort task: rc=138
[26705.746557] ------------[ cut here ]------------
[26705.746557] ------------[ cut here ]------------
[26705.760518] WARNING: CPU: 1 PID: 6796 at drivers/ata/libata-eh.c:4037 
ata_eh_finish+0xb4/0xcc
[26705.760518] WARNING: CPU: 1 PID: 6796 at drivers/ata/libata-eh.c:4037 
ata_eh_finish+0xb4/0xcc
[26705.782955] Modules linked in: debug_nic_mii(OE) hisi_sas_test_hw(OE) 
hisi_sas_test_main(OE)
[26705.782955] Modules linked in: debug_nic_mii(OE) hisi_sas_test_hw(OE) 
hisi_sas_test_main(OE)
[26705.806236] CPU: 1 PID: 6796 Comm: kworker/u4:2 Tainted: G 
OEL  4.14.0 #1
[26705.806236] CPU: 1 PID: 6796 Comm: kworker/u4:2 Tainted: G 
OEL  4.14.0 #1
[26705.827152] Workqueue: events_unbound async_run_entry_fn
[26705.827152] Workqueue: events_unbound async_run_entry_fn
[26705.841354] task: ffff8021f7761080 task.stack: ffff00000fb28000
[26705.841354] task: ffff8021f7761080 task.stack: ffff00000fb28000
[26705.857045] PC is at ata_eh_finish+0xb4/0xcc
[26705.857045] PC is at ata_eh_finish+0xb4/0xcc
[26705.868483] LR is at ata_do_eh+0x68/0xd8
[26705.868483] LR is at ata_do_eh+0x68/0xd8
[26705.878946] pc : [<ffff0000088baf70>] lr : [<ffff0000088bb764>] 
pstate: 60c00149
[26705.878946] pc : [<ffff0000088baf70>] lr : [<ffff0000088bb764>] 
pstate: 60c00149
[26705.898332] sp : ffff00000fb2bc40
[26705.898332] sp : ffff00000fb2bc40
[26705.907213] x29: ffff00000fb2bc40 x28: ffff8021ede761a0
[26705.907213] x29: ffff00000fb2bc40 x28: ffff8021ede761a0
[26705.921495] x27: 0000000000020200 x26: ffff8021ede76218
[26705.921495] x27: 0000000000020200 x26: ffff8021ede76218
[26705.935716] x25: ffff8021ede75e80 x24: 0000000000000140
[26705.935716] x25: ffff8021ede75e80 x24: 0000000000000140
[26705.949909] x23: ffff0000088adb8c x22: ffff000008878fe4
[26705.949909] x23: ffff0000088adb8c x22: ffff000008878fe4
[26705.964086] x21: ffff8021ede74000 x20: ffff8021ede75e38
[26705.964086] x21: ffff8021ede74000 x20: ffff8021ede75e38
[26705.978292] x19: ffff8021ede75e38 x18: 000000000003fee6
[26705.978292] x19: ffff8021ede75e38 x18: 000000000003fee6
[26705.992502] x17: 0000ffffbc4eb5b8 x16: ffff00000814a650
[26705.992502] x17: 0000ffffbc4eb5b8 x16: ffff00000814a650
[26706.006700] x15: 00001c71e0000000 x14: 0000000000000000
[26706.006700] x15: 00001c71e0000000 x14: 0000000000000000
[26706.020896] x13: 0000000000000000 x12: 0000000000000000
[26706.020896] x13: 0000000000000000 x12: 0000000000000000
[26706.035096] x11: 0000000000000000 x10: 0000000000000000
[26706.035096] x11: 0000000000000000 x10: 0000000000000000
[26706.049291] x9 : 0000000000000000 x8 : 0000000000000000
[26706.049291] x9 : 0000000000000000 x8 : 0000000000000000
[26706.063450] x7 : ffff8021ede75000 x6 : 0000000000000000
[26706.063450] x7 : ffff8021ede75000 x6 : 0000000000000000
[26706.077657] x5 : 0000000000000000 x4 : ffff8021ede75e80
[26706.077657] x5 : 0000000000000000 x4 : ffff8021ede75e80
[26706.091791] x3 : 0000000000000000 x2 : e51c5c8d83755700
[26706.091791] x3 : 0000000000000000 x2 : e51c5c8d83755700
[26706.105972] x1 : 0000000000000000 x0 : 0000000000000001
[26706.105972] x1 : 0000000000000000 x0 : 0000000000000001
[26706.120282] Call trace:
[26706.120282] Call trace:
[26706.127051] Exception stack(0xffff00000fb2bb00 to 0xffff00000fb2bc40)
[26706.127051] Exception stack(0xffff00000fb2bb00 to 0xffff00000fb2bc40)
[26706.144156] bb00: 0000000000000001 0000000000000000 e51c5c8d83755700 
0000000000000000
[26706.144156] bb00: 0000000000000001 0000000000000000 e51c5c8d83755700 
0000000000000000
[26706.164797] bb20: ffff8021ede75e80 0000000000000000 0000000000000000 
ffff8021ede75000
[26706.164797] bb20: ffff8021ede75e80 0000000000000000 0000000000000000 
ffff8021ede75000
[26706.185380] bb40: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[26706.185380] bb40: 0000000000000000 0000000000000000 0000000000000000 
0000000000000000
[26706.205972] bb60: 0000000000000000 0000000000000000 0000000000000000 
00001c71e0000000
[26706.205972] bb60: 0000000000000000 0000000000000000 0000000000000000 
00001c71e0000000
[26706.226616] bb80: ffff00000814a650 0000ffffbc4eb5b8 000000000003fee6 
ffff8021ede75e38
[26706.226616] bb80: ffff00000814a650 0000ffffbc4eb5b8 000000000003fee6 
ffff8021ede75e38
[26706.247247] bba0: ffff8021ede75e38 ffff8021ede74000 ffff000008878fe4 
ffff0000088adb8c
[26706.247247] bba0: ffff8021ede75e38 ffff8021ede74000 ffff000008878fe4 
ffff0000088adb8c
[26706.267813] bbc0: 0000000000000140 ffff8021ede75e80 ffff8021ede76218 
0000000000020200
[26706.267813] bbc0: 0000000000000140 ffff8021ede75e80 ffff8021ede76218 
0000000000020200
[26706.288375] bbe0: ffff8021ede761a0 ffff00000fb2bc40 ffff0000088bb764 
ffff00000fb2bc40
[26706.288375] bbe0: ffff8021ede761a0 ffff00000fb2bc40 ffff0000088bb764 
ffff00000fb2bc40
[26706.308933] bc00: ffff0000088baf70 0000000060c00149 ffff8021ede77790 
00000000088b8c60
[26706.308933] bc00: ffff0000088baf70 0000000060c00149 ffff8021ede77790 
00000000088b8c60
[26706.329512] bc20: ffffffffffffffff 0000000000000000 ffff00000fb2bc40 
ffff0000088baf70
[26706.329512] bc20: ffffffffffffffff 0000000000000000 ffff00000fb2bc40 
ffff0000088baf70
[26706.350156] [<ffff0000088baf70>] ata_eh_finish+0xb4/0xcc
[26706.350156] [<ffff0000088baf70>] ata_eh_finish+0xb4/0xcc
[26706.364260] [<ffff0000088bb764>] ata_do_eh+0x68/0xd8
[26706.364260] [<ffff0000088bb764>] ata_do_eh+0x68/0xd8
[26706.377497] [<ffff0000088bb818>] ata_std_error_handler+0x44/0x8c
[26706.377497] [<ffff0000088bb818>] ata_std_error_handler+0x44/0x8c
[26706.393406] [<ffff0000088bb408>] ata_scsi_port_error_handler+0x480/0x694
[26706.393406] [<ffff0000088bb408>] ata_scsi_port_error_handler+0x480/0x694
[26706.411352] [<ffff000008879364>] async_sas_ata_eh+0x4c/0x80
[26706.411352] [<ffff000008879364>] async_sas_ata_eh+0x4c/0x80
[26706.426133] [<ffff0000080f6be8>] async_run_entry_fn+0x4c/0x170
[26706.426133] [<ffff0000080f6be8>] async_run_entry_fn+0x4c/0x170
[26706.441841] [<ffff0000080ebd70>] process_one_work+0x144/0x390
[26706.441841] [<ffff0000080ebd70>] process_one_work+0x144/0x390
[26706.457057] [<ffff0000080ec100>] worker_thread+0x144/0x418
[26706.457057] [<ffff0000080ec100>] worker_thread+0x144/0x418
[26706.471610] [<ffff0000080f2c98>] kthread+0x10c/0x138
[26706.471610] [<ffff0000080f2c98>] kthread+0x10c/0x138
[26706.484991] [<ffff0000080855dc>] ret_from_fork+0x10/0x18
[26706.484991] [<ffff0000080855dc>] ret_from_fork+0x10/0x18
[26706.499044] ---[ end trace b555600a8adbf64c ]---
[26706.499044] ---[ end trace b555600a8adbf64c ]---
[26706.541683] scsi 2:0:48:0: [sdc] tag#1 FAILED Result: 
hostbyte=DID_ABORT driverbyte=DRIVER_OK
[26706.541683] scsi 2:0:48:0: [sdc] tag#1 FAILED Result: 
hostbyte=DID_ABORT driverbyte=DRIVER_OK
[26706.567810] scsi 2:0:48:0: [sdc] tag#1 CDB: Read(16) 88 00 00 00 00 
00 12 bf 94 b0 00 00 05 98 00 00
[26706.567810] scsi 2:0:48:0: [sdc] tag#1 CDB: Read(16) 88 00 00 00 00 
00 12 bf 94 b0 00 00 05 98 00 00
[26706.595023] print_req_error: I/O error, dev sdc, sector 314545328
[26706.595023] print_req_error: I/O error, dev sdc, sector 314545328
[26706.620247] scsi 2:0:48:0: [sdc] tag#0 FAILED Result: 
hostbyte=DID_ABORT driverbyte=DRIVER_OK
[26706.620247] scsi 2:0:48:0: [sdc] tag#0 FAILED Result: 
hostbyte=DID_ABORT driverbyte=DRIVER_OK
[26706.644961] scsi 2:0:48:0: [sdc] tag#0 CDB: Read(16) 88 00 00 00 00 
00 12 bf 8c b0 00 00 08 00 00 00
[26706.644961] scsi 2:0:48:0: [sdc] tag#0 CDB: Read(16) 88 00 00 00 00 
00 12 bf 8c b0 00 00 08 00 00 00
[26706.669886] print_req_error: I/O error, dev sdc, sector 314543280
[26706.669886] print_req_error: I/O error, dev sdc, sector 314543280
[26706.830360] hisi_sas_v3_hw 0000:74:02.0: dev[2:5] is gone
[26706.830360] hisi_sas_v3_hw 0000:74:02.0: dev[2:5] is gone
[26707.136481] hisi_sas_v3_hw 0000:74:02.0: phyup: phy2 link_rate=8(sata)
[26707.136481] hisi_sas_v3_hw 0000:74:02.0: phyup: phy2 link_rate=8(sata)
[26707.197919] hisi_sas_v3_hw 0000:74:02.0: dev[2:5] found
[26707.197919] hisi_sas_v3_hw 0000:74:02.0: dev[2:5] found
[26707.591580] ata17.00: ATA-9: HUS726060ALE610, T7MH, max UDMA/133
[26707.591580] ata17.00: ATA-9: HUS726060ALE610, T7MH, max UDMA/133
[26707.609692] ata17.00: 11721045168 sectors, multi 0: LBA48 NCQ (depth 
31/32)
[26707.609692] ata17.00: 11721045168 sectors, multi 0: LBA48 NCQ (depth 
31/32)
[26707.684979] ata17.00: configured for UDMA/133
[26707.684979] ata17.00: configured for UDMA/133
[26707.875096] scsi 2:0:56:0: Direct-Access     ATA      HUS726060ALE610 
  T7MH PQ: 0 ANSI: 5
[26707.875096] scsi 2:0:56:0: Direct-Access     ATA      HUS726060ALE610 
  T7MH PQ: 0 ANSI: 5
[26708.110173] sd 2:0:56:0: [sdc] 11721045168 512-byte logical blocks: 
(6.00 TB/5.46 TiB)
[26708.110173] sd 2:0:56:0: [sdc] 11721045168 512-byte logical blocks: 
(6.00 TB/5.46 TiB)
[26708.135492] sd 2:0:56:0: [sdc] 4096-byte physical blocks
[26708.135492] sd 2:0:56:0: [sdc] 4096-byte physical blocks
[26708.209552] sd 2:0:56:0: [sdc] Write Protect is off
[26708.209552] sd 2:0:56:0: [sdc] Write Protect is off
[26708.236055] sd 2:0:56:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[26708.236055] sd 2:0:56:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[26708.615290] sd 2:0:56:0: [sdc] Attached SCSI disk
[26708.615290] sd 2:0:56:0: [sdc] Attached SCSI disk
[26718.256091] hisi_sas_v3_hw 0000:74:02.0: phydown: phy3 phy_state=0xf7
[26718.256091] hisi_sas_v3_hw 0000:74:02.0: phydown: phy3 phy_state=0xf7
[26718.451643] sd 2:0:49:0: [sdd] Synchronizing SCSI cache
[26718.451643] sd 2:0:49:0: [sdd] Synchronizing SCSI cache
[26718.489868] sd 2:0:49:0: [sdd] Synchronize Cache(10) failed: Result: 
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[26718.489868] sd 2:0:49:0: [sdd] Synchronize Cache(10) failed: Result: 
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[26718.520730] sd 2:0:49:0: [sdd] Stopping disk
[26718.520730] sd 2:0:49:0: [sdd] Stopping disk
[26718.537621] sd 2:0:49:0: [sdd] Start/Stop Unit failed: Result: 
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[26718.537621] sd 2:0:49:0: [sdd] Start/Stop Unit failed: Result: 
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[26718.727537] hisi_sas_v3_hw 0000:74:02.0: dev[3:5] is gone
[26718.727537] hisi_sas_v3_hw 0000:74:02.0: dev[3:5] is gone
[26729.780626] hisi_sas_v3_hw 0000:74:02.0: phyup: phy3 link_rate=8(sata)
[26729.780626] hisi_sas_v3_hw 0000:74:02.0: phyup: phy3 link_rate=8(sata)
[26729.840148] hisi_sas_v3_hw 0000:74:02.0: dev[3:5] found
[26729.840148] hisi_sas_v3_hw 0000:74:02.0: dev[3:5] found
[26730.099183] ata18.00: ATA-10: INTEL SSDSC2BB960G7, N2010101, max UDMA/133
[26730.099183] ata18.00: ATA-10: INTEL SSDSC2BB960G7, N2010101, max UDMA/133
[26730.118817] ata18.00: 1875385008 sectors, multi 1: LBA48 NCQ (depth 
31/32)
[26730.118817] ata18.00: 1875385008 sectors, multi 1: LBA48 NCQ (depth 
31/32)
[26730.163992] ata18.00: configured for UDMA/133
[26730.163992] ata18.00: configured for UDMA/133
[26730.368127] scsi 2:0:57:0: Direct-Access     ATA      INTEL 
SSDSC2BB96 0101 PQ: 0 ANSI: 5
[26730.368127] scsi 2:0:57:0: Direct-Access     ATA      INTEL 
SSDSC2BB96 0101 PQ: 0 ANSI: 5
[26730.485519] ata18.00: Enabling discard_zeroes_data
[26730.485519] ata18.00: Enabling discard_zeroes_data
[26730.562133] sd 2:0:57:0: [sdd] 1875385008 512-byte logical blocks: 
(960 GB/894 GiB)
[26730.562133] sd 2:0:57:0: [sdd] 1875385008 512-byte logical blocks: 
(960 GB/894 GiB)
[26730.586390] sd 2:0:57:0: [sdd] 4096-byte physical blocks
[26730.586390] sd 2:0:57:0: [sdd] 4096-byte physical blocks
[26730.624535] sd 2:0:57:0: [sdd] Write Protect is off
[26730.624535] sd 2:0:57:0: [sdd] Write Protect is off
[26730.655565] sd 2:0:57:0: [sdd] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[26730.655565] sd 2:0:57:0: [sdd] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[26730.758190] ata18.00: Enabling discard_zeroes_data
[26730.758190] ata18.00: Enabling discard_zeroes_data
[26730.965130] ata18.00: Enabling discard_zeroes_data
[26730.965130] ata18.00: Enabling discard_zeroes_data
[26731.035218] sd 2:0:57:0: [sdd] Attached SCSI disk
[26731.035218] sd 2:0:57:0: [sdd] Attached SCSI disk
[26741.033891] hisi_sas_v3_hw 0000:74:02.0: phydown: phy4 phy_state=0xef
[26741.033891] hisi_sas_v3_hw 0000:74:02.0: phydown: phy4 phy_state=0xef
[26741.262803] sd 2:0:50:0: [sde] Synchronizing SCSI cache
[26741.262803] sd 2:0:50:0: [sde] Synchronizing SCSI cache
[26741.291251] sd 2:0:50:0: [sde] Synchronize Cache(10) failed: Result: 
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[26741.291251] sd 2:0:50:0: [sde] Synchronize Cache(10) failed: Result: 
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[26741.452295] hisi_sas_v3_hw 0000:74:02.0: dev[4:1] is gone
[26741.452295] hisi_sas_v3_hw 0000:74:02.0: dev[4:1] is gone

--IPOP Time:12/3/2017_2:06:57--
[26752.519335] hisi_sas_v3_hw 0000:74:02.0: phyup: phy4 link_rate=8
[26752.519335] hisi_sas_v3_hw 0000:74:02.0: phyup: phy4 link_rate=8
[26752.603868] hisi_sas_v3_hw 0000:74:02.0: dev[4:1] found
[26752.603868] hisi_sas_v3_hw 0000:74:02.0: dev[4:1] found
[26752.761954] scsi 2:0:58:0: Direct-Access     HGST     HUC156060CS4200 
  A360 PQ: 0 ANSI: 6
[26752.761954] scsi 2:0:58:0: Direct-Access     HGST     HUC156060CS4200 
  A360 PQ: 0 ANSI: 6
[26753.016839] sd 2:0:58:0: [sde] 146515446 4096-byte logical blocks: 
(600 GB/559 GiB)
[26753.016839] sd 2:0:58:0: [sde] 146515446 4096-byte logical blocks: 
(600 GB/559 GiB)
[26753.060446] sd 2:0:58:0: [sde] Write Protect is off
[26753.060446] sd 2:0:58:0: [sde] Write Protect is off
[26753.112410] sd 2:0:58:0: [sde] Write cache: enabled, read cache: 
enabled, supports DPO and FUA
[26753.112410] sd 2:0:58:0: [sde] Write cache: enabled, read cache: 
enabled, supports DPO and FUA
[26754.048264] sd 2:0:58:0: [sde] Attached SCSI disk
[26754.048264] sd 2:0:58:0: [sde] Attached SCSI disk
[26763.914651] hisi_sas_v3_hw 0000:74:02.0: phydown: phy5 phy_state=0xdf
[26763.914651] hisi_sas_v3_hw 0000:74:02.0: phydown: phy5 phy_state=0xdf
[26764.123860] sd 2:0:51:0: [sdf] Synchronizing SCSI cache
[26764.123860] sd 2:0:51:0: [sdf] Synchronizing SCSI cache
[26764.160910] sd 2:0:51:0: [sdf] Synchronize Cache(10) failed: Result: 
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[26764.160910] sd 2:0:51:0: [sdf] Synchronize Cache(10) failed: Result: 
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[26764.349635] hisi_sas_v3_hw 0000:74:02.0: dev[5:1] is gone
[26764.349635] hisi_sas_v3_hw 0000:74:02.0: dev[5:1] is gone
[26775.341199] hisi_sas_v3_hw 0000:74:02.0: phyup: phy5 link_rate=8
[26775.341199] hisi_sas_v3_hw 0000:74:02.0: phyup: phy5 link_rate=8
[26775.417619] hisi_sas_v3_hw 0000:74:02.0: dev[5:1] found
[26775.417619] hisi_sas_v3_hw 0000:74:02.0: dev[5:1] found
[26775.571880] scsi 2:0:59:0: Direct-Access     HITACHI  HUC109090CSS600 
  A440 PQ: 0 ANSI: 6
[26775.571880] scsi 2:0:59:0: Direct-Access     HITACHI  HUC109090CSS600 
  A440 PQ: 0 ANSI: 6
[26775.797378] sd 2:0:59:0: [sdf] 1758174768 512-byte logical blocks: 
(900 GB/838 GiB)
[26775.797378] sd 2:0:59:0: [sdf] 1758174768 512-byte logical blocks: 
(900 GB/838 GiB)
[26775.835526] sd 2:0:59:0: [sdf] Write Protect is off
[26775.835526] sd 2:0:59:0: [sdf] Write Protect is off
[26775.892457] sd 2:0:59:0: [sdf] Write cache: enabled, read cache: 
enabled, supports DPO and FUA
[26775.892457] sd 2:0:59:0: [sdf] Write cache: enabled, read cache: 
enabled, supports DPO and FUA
[26776.788901] sd 2:0:59:0: [sdf] Attached SCSI disk
[26776.788901] sd 2:0:59:0: [sdf] Attached SCSI disk
[26786.638978] hisi_sas_v3_hw 0000:74:02.0: phydown: phy6 phy_state=0xbf
[26786.638978] hisi_sas_v3_hw 0000:74:02.0: phydown: phy6 phy_state=0xbf
[26786.868652] sd 2:0:52:0: [sdg] Synchronizing SCSI cache
[26786.868652] sd 2:0:52:0: [sdg] Synchronizing SCSI cache
[26786.905217] sd 2:0:52:0: [sdg] Synchronize Cache(10) failed: Result: 
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[26786.905217] sd 2:0:52:0: [sdg] Synchronize Cache(10) failed: Result: 
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
[26787.060205] hisi_sas_v3_hw 0000:74:02.0: dev[6:1] is gone
[26787.060205] hisi_sas_v3_hw 0000:74:02.0: dev[6:1] is gone
[26798.172445] hisi_sas_v3_hw 0000:74:02.0: phyup: phy6 link_rate=8
[26798.172445] hisi_sas_v3_hw 0000:74:02.0: phyup: phy6 link_rate=8
[26798.255947] hisi_sas_v3_hw 0000:74:02.0: dev[6:1] found
[26798.255947] hisi_sas_v3_hw 0000:74:02.0: dev[6:1] found
[26798.437811] scsi 2:0:60:0: Direct-Access     SEAGATE  ST300MM0008 
   N003 PQ: 0 ANSI: 6
[26798.437811] scsi 2:0:60:0: Direct-Access     SEAGATE  ST300MM0008 
   N003 PQ: 0 ANSI: 6
[26799.063474] sd 2:0:60:0: [sdg] 585937500 512-byte logical blocks: 
(300 GB/279 GiB)
[26799.063474] sd 2:0:60:0: [sdg] 585937500 512-byte logical blocks: 
(300 GB/279 GiB)
[26799.119535] sd 2:0:60:0: [sdg] Write Protect is off
[26799.119535] sd 2:0:60:0: [sdg] Write Protect is off
[26799.172090] sd 2:0:60:0: [sdg] Write cache: enabled, read cache: 
enabled, supports DPO and FUA
[26799.172090] sd 2:0:60:0: [sdg] Write cache: enabled, read cache: 
enabled, supports DPO and FUA
[26799.760024] sd 2:0:60:0: [sdg] Attached SCSI disk
[26799.760024] sd 2:0:60:0: [sdg] Attached SCSI disk
[26809.413584] hisi_sas_v3_hw 0000:74:02.0: phydown: phy7 phy_state=0x7f
[26809.413584] hisi_sas_v3_hw 0000:74:02.0: phydown: phy7 phy_state=0x7f
[26809.631741] sd 2:0:53:0: [sdh] Synchronizing SCSI cache
[26809.631741] sd 2:0:53:0: [sdh] Synchronizing SCSI cache

