From: Ido Schimmel <idosch@mellanox.com>
Subject: Re: Regression due to "libata: implement SECURITY PROTOCOL IN/OUT"
Date: Thu, 24 Aug 2017 15:18:04 +0300
Message-ID: <20170824121804.GA14057@shredder.mtl.com>
References: <20170824112932.GA12461@shredder.mtl.com>
 <20170824120728.GA23186@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-db5eur01on0048.outbound.protection.outlook.com ([104.47.2.48]:9431
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751334AbdHXMSN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 24 Aug 2017 08:18:13 -0400
Content-Disposition: inline
In-Reply-To: <20170824120728.GA23186@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: tj@kernel.org, xiaolong.ye@intel.com, mlxsw@mellanox.com, michaelsh@mellanox.com, linux-ide@vger.kernel.org

On Thu, Aug 24, 2017 at 02:07:29PM +0200, Christoph Hellwig wrote:
> What kind of device is this?   Seems like we need to blacklist it
> as it chokes when we tried to read the Identify Devіce Log.

Is the below enough or do you need more info?

$ smartctl -a /dev/sda

=== START OF INFORMATION SECTION ===
Model Family:     Innodisk 3IE3/3ME3 SSDs
Device Model:     M.2 (S42) 3ME3
Serial Number:    20161029AA101511210E
LU WWN Device Id: 5 24693e 2016a210e
Firmware Version: S15A19
User Capacity:    16,013,942,784 bytes [16.0 GB]
Sector Size:      512 bytes logical/physical
Rotation Rate:    Solid State Device
Form Factor:      2.5 inches
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   ATA8-ACS (minor revision not indicated)
SATA Version is:  SATA 3.0, 6.0 Gb/s (current: 6.0 Gb/s)
Local Time is:    Thu Aug 24 15:10:44 2017 IDT
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x00) Offline data collection activity
                                        was never started.
                                        Auto Offline Data Collection: Disabled.
Total time to complete Offline 
data collection:                (   32) seconds.
Offline data collection
capabilities:                    (0x00)         Offline data collection not supported.
SMART capabilities:            (0x0003) Saves SMART data before entering
                                        power-saving mode.
                                        Supports SMART auto save timer.
Error logging capability:        (0x00) Error logging NOT supported.
                                        General Purpose Logging supported.
SCT capabilities:              (0x0039) SCT Status supported.
                                        SCT Error Recovery Control supported.
                                        SCT Feature Control supported.
                                        SCT Data Table supported.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x0000   000   000   000    Old_age   Offline      -       0
  2 Throughput_Performance  0x0000   000   000   000    Old_age   Offline      -       0
  3 Spin_Up_Time            0x0000   000   000   000    Old_age   Offline      -       0
  5 Later_Bad_Block         0x0013   100   100   001    Pre-fail  Always       -       0
  7 Seek_Error_Rate         0x0000   000   000   000    Old_age   Offline      -       0
  8 Seek_Time_Performance   0x0000   000   000   000    Old_age   Offline      -       0
  9 Power_On_Hours          0x0002   255   000   000    Old_age   Always       -       255
 10 Spin_Retry_Count        0x0000   000   000   000    Old_age   Offline      -       0
 12 Power_Cycle_Count       0x0002   097   000   000    Old_age   Always       -       97
163 Total_Bad_Block_Count   0x0000   000   000   000    Old_age   Offline      -       13
168 SATA_PHY_Error_Count    0x0000   000   000   000    Old_age   Offline      -       0
169 Remaining_Lifetime_Perc 0x0000   099   000   000    Old_age   Offline      -       99
175 Bad_Cluster_Table_Count 0x0000   000   000   000    Old_age   Offline      -       0
192 Power-Off_Retract_Count 0x0000   000   000   000    Old_age   Offline      -       0
194 Temperature_Celsius     0x0000   030   100   000    Old_age   Offline      -       30 (2 100 0 0 0)
197 Current_Pending_Sector  0x0012   000   100   000    Old_age   Always       -       0
225 Data_Log_Write_Count    0x0000   000   240   000    Old_age   Offline      -       272040
240 Write_Head              0x0000   000   000   000    Old_age   Offline      -       0
165 Max_Erase_Count         0x0002   010   001   000    Old_age   Always       -       10
167 Average_Erase_Count     0x0002   005   001   000    Old_age   Always       -       5
170 Spare_Block_Count       0x0003   100   001   000    Pre-fail  Always       -       65
171 Program_Fail_Count      0x0002   000   001   000    Old_age   Always       -       0
172 Erase_Fail_Count        0x0002   000   001   000    Old_age   Always       -       0
176 RANGE_RECORD_Count      0x0000   100   001   000    Old_age   Offline      -       0
187 Reported_Uncorrect      0x0002   000   001   000    Old_age   Always       -       0
229 Flash_ID                0x0002   100   001   000    Old_age   Always       -       0x51769394de98
232 Spares_Remaining_Perc   0x0003   100   001   000    Pre-fail  Always       -       0
235 Later_Bad_Blk_Inf_R/W/E 0x0002   000   000   000    Old_age   Always       -       0 0 0
241 Host_Writes_32MiB       0x0002   100   001   000    Old_age   Always       -       1062
242 Host_Reads_32MiB        0x0002   100   001   000    Old_age   Always       -       762
