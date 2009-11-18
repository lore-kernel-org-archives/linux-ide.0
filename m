From: Marc MERLIN <marc@merlins.org>
Subject: Re: help with PMP failures
Date: Tue, 17 Nov 2009 23:41:45 -0800
Message-ID: <20091118074145.GA24488@merlins.org>
References: <20091116184242.GA22250@merlins.org> <20091116184853.GA23126@merlins.org> <4B0238EC.6060803@kernel.org> <20091117173955.GA19029@merlins.org> <4B0371F4.9060703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from magic.merlins.org ([209.81.13.136]:45163 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426AbZKRHln (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Nov 2009 02:41:43 -0500
Content-Disposition: inline
In-Reply-To: <4B0371F4.9060703@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

On Wed, Nov 18, 2009 at 01:03:00PM +0900, Tejun Heo wrote:
> Hello,
> 
> 11/18/2009 02:39 AM, Marc MERLIN wrote:
> >> This is the actual failure.  Your 6.02 drive reported media error
> >> which combined with the controller errata caused port wide failure.
> >  
> > Ah, I see, so it should be the one for me to focus on.
> > If it hadn't had an error, everything wouldn't have gone down the toilet,
> > next, right?
> 
> Yes, that's my guess.
> 
> > scsi 6:2:0:0: Direct-Access     ATA      Hitachi HDS72101 GKAO PQ: 0 ANSI: 5
> > sd 6:2:0:0: [sdj] 1953525168 512-byte hardware sectors: (1.00 TB/931 GiB)
> >
> > If it's a media error, shouldn't it show up in the smart counters?
> 
> Does smartctl -a output shows any logged errors?

Didn't know about -a, good call.
Yep, they do and the times are about consistent with the raid going down

Not sure if the last 5 errors are enough to give a good clue, or not.

If I can't quite figure it out, I'll just pop in a 16 port adaptec sata 
board I recently picked up. It'll take PMP out of the equation if I truly
have drives returning read / write errors that don't quite seem to show up
in smart yet.

  9 Power_On_Hours          0x0012   098   098   000    Old_age   Always       -       18580

 
SMART Error Log Version: 1
ATA Error Count: 47 (device log contains only the most recent five errors)
        CR = Command Register [HEX]
        FR = Features Register [HEX]
        SC = Sector Count Register [HEX]
        SN = Sector Number Register [HEX]
        CL = Cylinder Low Register [HEX]
        CH = Cylinder High Register [HEX]
        DH = Device/Head Register [HEX]
        DC = Device Command Register [HEX]
        ER = Error register [HEX]
        ST = Status register [HEX]
Powered_Up_Time is measured from power on, and printed as
DDd+hh:mm:SS.sss where DD=days, hh=hours, mm=minutes,
SS=sec, and sss=millisec. It "wraps" after 49.710 days.

Error 47 occurred at disk power-on lifetime: 18547 hours (772 days + 19 hours)
  When the command that caused the error occurred, the device was active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 00 46 59 70 44

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  61 08 00 3f 59 70 40 08  13d+19:41:56.500  WRITE FPDMA QUEUED
  ea 00 00 00 00 00 a0 08  13d+19:41:56.500  FLUSH CACHE EXIT
  ea 00 00 00 00 00 a0 08  13d+19:41:56.200  FLUSH CACHE EXIT
  61 08 00 3f 59 70 40 08  13d+19:41:56.200  WRITE FPDMA QUEUED
  ea 00 00 00 00 00 a0 08  13d+19:41:56.200  FLUSH CACHE EXIT

Error 46 occurred at disk power-on lifetime: 18546 hours (772 days + 18 hours)
  When the command that caused the error occurred, the device was active or idle.
  
  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 00 46 59 70 44
  
  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  61 08 00 3f 59 70 40 08  13d+19:27:26.400  WRITE FPDMA QUEUED
  27 00 00 00 00 00 e0 08  13d+19:27:26.400  READ NATIVE MAX ADDRESS EXT
  ec 00 00 00 00 00 a0 08  13d+19:27:26.400  IDENTIFY DEVICE
  ef 03 45 00 00 00 a0 08  13d+19:27:26.400  SET FEATURES [Set transfer mode]
  27 00 00 00 00 00 e0 08  13d+19:27:26.400  READ NATIVE MAX ADDRESS EXT

Error 45 occurred at disk power-on lifetime: 18546 hours (772 days + 18 hours)
  When the command that caused the error occurred, the device was active or idle.
  
  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 00 46 59 70 44
  
  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  61 08 00 3f 59 70 40 08  13d+19:27:26.100  WRITE FPDMA QUEUED
  ea 00 00 00 00 00 a0 08  13d+19:27:26.100  FLUSH CACHE EXIT
  ea 00 00 00 00 00 a0 08  13d+19:27:25.800  FLUSH CACHE EXIT
  61 08 00 3f 59 70 40 08  13d+19:27:25.800  WRITE FPDMA QUEUED
  27 00 00 00 00 00 e0 08  13d+19:27:25.800  READ NATIVE MAX ADDRESS EXT

Error 44 occurred at disk power-on lifetime: 18546 hours (772 days + 18 hours)
  When the command that caused the error occurred, the device was active or idle.
  
  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 00 46 59 70 44
  
  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  61 08 00 3f 59 70 40 08  13d+19:27:24.900  WRITE FPDMA QUEUED
  ea 00 00 00 00 00 a0 08  13d+19:27:24.900  FLUSH CACHE EXIT
  b0 d0 01 00 4f c2 00 08  13d+19:20:22.300  SMART READ DATA
  b0 d8 00 00 4f c2 00 08  13d+19:20:22.100  SMART ENABLE OPERATIONS
  e5 00 00 00 00 00 00 08  13d+19:20:22.100  CHECK POWER MODE

Error 43 occurred at disk power-on lifetime: 18546 hours (772 days + 18 hours)
  When the command that caused the error occurred, the device was active or idle.
  
  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 00 46 59 70 44
  
  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  61 08 00 3f 59 70 40 08  13d+19:12:24.500  WRITE FPDMA QUEUED
  ea 00 00 00 00 00 a0 08  13d+19:12:24.500  FLUSH CACHE EXIT
  ea 00 00 00 00 00 a0 08  13d+19:12:23.600  FLUSH CACHE EXIT
  61 08 00 3f 59 70 40 08  13d+19:12:23.600  WRITE FPDMA QUEUED
  ea 00 00 00 00 00 a0 08  13d+19:12:23.600  FLUSH CACHE EXIT

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error
# 1  Short offline       Completed without error       00%     18565         -
# 2  Short offline       Completed without error       00%     18535         -
# 3  Short offline       Completed without error       00%     18511         -
# 4  Extended offline    Completed without error       00%     18492         -
# 5  Short offline       Completed without error       00%     18487         -
# 6  Short offline       Completed without error       00%     18463         -
# 7  Short offline       Completed without error       00%     18439         -
# 8  Short offline       Completed without error       00%     18415         -
# 9  Short offline       Completed without error       00%     18391         -
#10  Short offline       Completed without error       00%     18366         -
#11  Short offline       Completed without error       00%     18343         -
#12  Extended offline    Completed without error       00%     18324         -
#13  Short offline       Completed without error       00%     18319         -
#14  Short offline       Completed without error       00%     18295         -
#15  Short offline       Completed without error       00%     18271         -
#16  Short offline       Completed without error       00%     18247         -
#17  Short offline       Completed without error       00%     18223         -
#18  Short offline       Completed without error       00%     18199         -
#19  Short offline       Completed without error       00%     18178         -
#20  Short offline       Completed without error       00%     18178         -
#21  Short offline       Completed without error       00%     18178         -

SMART Selective self-test log data structure revision number 1
 SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
    1        0        0  Not_testing
    2        0        0  Not_testing
    3        0        0  Not_testing
    4        0        0  Not_testing
    5        0        0  Not_testing
Selective self-test flags (0x0):
  After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.


Thanks for looking,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems & security ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
