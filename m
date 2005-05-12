From: "Brian Rademacher" <rad@radfiles.net>
Subject: $100 reward! - Marvell 88SX6081 disk problem during high load...
Date: Thu, 12 May 2005 00:05:10 -0600
Message-ID: <005e01c556b8$8e1db550$0301a8c0@Rad>
Reply-To: Brian Rademacher <rad@radfiles.net>,
	For testers of Fedora Core development releases <fedora-test-list@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <fedora-test-list-bounces@redhat.com>
List-Unsubscribe: <http://www.redhat.com/mailman/listinfo/fedora-test-list>,
	<mailto:fedora-test-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/fedora-test-list>
List-Post: <mailto:fedora-test-list@redhat.com>
List-Help: <mailto:fedora-test-list-request@redhat.com?subject=help>
List-Subscribe: <http://www.redhat.com/mailman/listinfo/fedora-test-list>,
	<mailto:fedora-test-list-request@redhat.com?subject=subscribe>
Sender: fedora-test-list-bounces@redhat.com
Errors-To: fedora-test-list-bounces@redhat.com
To: fedora-test-list@redhat.com
Cc: linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Yes, I'm desperate, and $100 will be immediately sent your way (paypal, or 
whatever form you want) upon resolution of the problem by you...I've been 
trying for months to get a Marvell 88SX6081 on an ABIT SU-2S motherboard to 
work under Fedora...Thought I would post some of the relevent dmesg output 
to see if anyone has any ideas...Long story short, under a high load (in 
this case, just trying to format the drives), they go offline and never come 
back...This happens under FC4T3 and FC3 I'm using two Maxtor Diamondmax 10 
300 gig SATA-II drives (6B300S0)...

I tested both drives for errors on a different system and they are fine...I 
have also tried various versions of drive firmware from Maxtor with no 
luck...If I keep the load low, things work fine...I have been able to format 
in the past by increasing the inode size, thus causing less load during the 
format, although it crashed later on with the same errors during an updatedb 
operation...

I have a feeling that this is driver related, which is a bad thing, as ABIT 
no longer supports my SU-2S motherboard and Marvell doesn't support end 
users...I have tried A LOT of things in relation to this problem, but feel 
free to suggest them again anyway...

As far as the reward goes, it will go to the first person that comes up with 
the solution (which must be practical for me, and not something like "write 
your own libata driver") as judged by the email receipt time...(anyone want 
to rewrite a driver?  I have the GPL source)...


Here is the driver init:
ACPI: PCI Interrupt 0000:02:03.0[A] -> GSI 26 (level, low) -> IRQ 201
scsi0 : Marvell SCSI to SATA adapter
scsi1 : Marvell SCSI to SATA adapter
scsi2 : Marvell SCSI to SATA adapter
scsi3 : Marvell SCSI to SATA adapter
scsi4 : Marvell SCSI to SATA adapter
scsi5 : Marvell SCSI to SATA adapter
scsi6 : Marvell SCSI to SATA adapter
scsi7 : Marvell SCSI to SATA adapter
  Vendor: Maxtor    Model: 6B300S0           Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 586114704 512-byte hdwr sectors (300091 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: Maxtor    Model: 6B300S0           Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 586114704 512-byte hdwr sectors (300091 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0


Then this happens mid-way through the format:
cfq: depth 4 reached, tagging now on
cfq: depth 4 reached, tagging now on
scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 
0 lun 0
scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 
0 lun 0
scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 
0 lun 0
scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 
0 lun 0
scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 
0 lun 0
scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 
0 lun 0
(lots of these device offlined message)


Followed by:
SCSI error : <0 0 0 0> return code = 0x8
end_request: I/O error, dev sda, sector 407850128
Buffer I/O error on device md0, logical block 101384192
lost page write due to I/O error on md0
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device md0, logical block 101384193
lost page write due to I/O error on md0
scsi0 (0:0): rejecting I/O to offline device
Buffer I/O error on device md0, logical block 102400000
lost page write due to I/O error on md0
Buffer I/O error on device md0, logical block 102400001
lost page write due to I/O error on md0
Buffer I/O error on device md0, logical block 102400002
lost page write due to I/O error on md0
Buffer I/O error on device md0, logical block 102400003
lost page write due to I/O error on md0
Buffer I/O error on device md0, logical block 102400004
lost page write due to I/O error on md0
Buffer I/O error on device md0, logical block 102400005
lost page write due to I/O error on md0
Buffer I/O error on device md0, logical block 102400006
lost page write due to I/O error on md0
Buffer I/O error on device md0, logical block 102400007
lost page write due to I/O error on md0
scsi0 (0:0): rejecting I/O to offline device
scsi0 (0:0): rejecting I/O to offline device
scsi0 (0:0): rejecting I/O to offline device
scsi0 (0:0): rejecting I/O to offline device
scsi0 (0:0): rejecting I/O to offline device
scsi0 (0:0): rejecting I/O to offline device
(lots of these messages)


And then:
SCSI error : <0 0 0 0> return code = 0x8
end_request: I/O error, dev sda, sector 407981200
scsi0 (0:0): rejecting I/O to offline device
SCSI error : <0 0 0 0> return code = 0x8
end_request: I/O error, dev sda, sector 408112272
scsi0 (0:0): rejecting I/O to offline device
(lots of these with various sectors listed)


And last:
Synchronizing SCSI cache for disk sda:
FAILED
  status = 0, message = 00, host = 1, driver = 00 

-- 
fedora-test-list mailing list
fedora-test-list@redhat.com
To unsubscribe: 
http://www.redhat.com/mailman/listinfo/fedora-test-list
