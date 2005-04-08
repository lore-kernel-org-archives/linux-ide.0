From: "Eric A. Cottrell" <eac@shore.net>
Subject: LIBATA AHCI engine timeout hang with ATAPI devices
Date: Fri, 08 Apr 2005 14:47:05 -0400
Message-ID: <4256D1A9.6080401@shore.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.primushost.com ([209.58.220.65]:50082 "EHLO
	smtp1.primushost.com") by vger.kernel.org with ESMTP
	id S262918AbVDHSrM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 Apr 2005 14:47:12 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I made the mistake of getting the Plextor SATA DVD Recorder with my new system not realizing that SATA support is just coming 
online.  I want to turn this into an opportunity to make the Plextor work.  Thanks to the IDE information pages I got a good start.

I have success using the ata_piix and ahci drivers with SATA Hard Drives.  I noticed that the Plextor works with the ata_piix driver 
  but not with the AHCI driver.  The AHCI driver hangs after the INQUIRY is printed.

System is a P4 3.4 GHz with a Asus P5AD-2 Premium (925XE chipset) MB with 1M Memory.  Processor is running at 3.5 GHz with a 1GHz 
FSB. I am using the 2.6.12-rc2 kernel for testing.

It looks to me like the AHCI driver is not doing a request sense when the engine timeout function is called.  The queued command is 
not properly released after the engine timeout so no more commands are processed.  I also noticed that the TEST UNIT READY command 
is sent by the SCSI code when the AHCI driver is used instead of the REPORT LUN command.

I would like to work on fixing this problem unless it has already been fixed.

The ata_piix Good Log

scsi scan: INQUIRY successful with code 0x0
   Vendor: PLEXTOR   Model: DVDR   PX-716A    Rev: 1.04
Type:   CD-ROM                             ANSI SCSI revision: 05
scsi scan: Sending REPORT LUNS to host 0 channel 0 id 0 (try 0)
Leaving scsi_init_cmd_from_req()
scsi_add_timer: scmd: f759eb00, time: 6000, (f8baa860)
scsi <0:0:0:0> send 0xf759eb00                  scsi0 : destination target 0, lun 0
         command: Report luns: a0 00 00 00 00 00 00 00 10 00 00 00
buffer = 0xf639c000, bufflen = 4096, done = 0xf8bacae0, queuecommand 0xf8bd23d0
ata_scsi_dump_cdb: CDB (1:0,0,0) a0 00 00 00 00 00 00 00 10
ata_scsi_translate: ENTER
ata_sg_setup_one: mapped buffer of 4096 bytes for read
ata_fill_sg: PRD[0] = (0x3639C000, 0x1000)
ata_dev_select: ENTER, ata1: device 0, wait 1
ata_tf_load_pio: feat 0x1 nsect 0x0 lba 0x0 0x0 0x0
ata_tf_load_pio: device 0xA0
ata_exec_command_pio: ata1: cmd 0xA0
ata_scsi_translate: EXIT
leaving scsi_dispatch_cmnd()
atapi_packet_task: busy wait
atapi_packet_task: send cdb
ata_host_intr: ata1: host_stat 0x25
ata_host_intr: ata1: protocol 7 (dev_stat 0x51)
ata_sg_clean: unmapping 1 sg elements
atapi_qc_complete: request check condition
scsi_delete_timer: scmd: f759eb00, rtn: 1
scsi <0:0:0:0> done 0xf759eb00 FAILED         2 scsi0 : destination target 0, lun 0
         command: Report luns: a0 00 00 00 00 00 00 00 10 00 00 00
Unrecognized sense data (in hex):
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
scsi host busy 1 failed 0
Waking error handler thread
Error handler scsi_eh_0 waking up
ata_scsi_error: ENTER
ata_eng_timeout: ENTER
ata_qc_timeout: ENTER
atapi_request_sense: ATAPI request sense
ata_dev_select: ENTER, ata1: device 0, wait 1
ata_tf_load_pio: feat 0x0 nsect 0x0 lba 0x0 0x0 0x20
ata_tf_load_pio: device 0xA0
ata_exec_command_pio: ata1: cmd 0xA0
atapi_packet_task: busy wait
atapi_packet_task: send cdb
__atapi_pio_bytes: data read
ata_qc_complete: EXIT
atapi_request_sense: EXIT
Notifying upper driver of completion for device 0 8000002
ata_qc_timeout: EXIT
ata_eng_timeout: EXIT
ata_scsi_error: EXIT
scsi_restart_operations: waking up host to restart
Error handler scsi_eh_0 sleeping
scsi scan: REPORT LUNS failed (try 0) result 0x8000002
scsi scan: Sequential scan oftarget0:0:0

The AHCI bad log

scsi scan: INQUIRY successful with code 0x0
   Vendor: PLEXTOR   Model: DVDR   PX-716A    Rev: 1.04
   Type:   CD-ROM                             ANSI SCSI revision: 05
Leaving scsi_init_cmd_from_req()
scsi_add_timer: scmd: f29f6e00, time: 30000, (f8baa860)
scsi <2:0:0:0> send 0xf29f6e00                  scsi2 : destination target 0, lun 0
         command: Test Unit Ready: 00 00 00 00 00 00
buffer = 0xc04d4e00, bufflen = 0, done = 0xf8bacae0, queuecommand 0xf8bd23d0
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 00
ata_scsi_translate: ENTER
ata_scsi_translate: EXIT
leaving scsi_dispatch_cmnd()
ahci_interrupt: ENTER
ahci_interrupt: port 0
ata1: error occurred, port reset
atapi_qc_complete: request check condition
scsi_delete_timer: scmd: f29f6e00, rtn: 1
ahci_interrupt: port 1
ahci_interrupt: port 2
ahci_interrupt: port 3
ahci_interrupt: EXIT
scsi <2:0:0:0> done 0xf29f6e00 FAILED         2 scsi2 : destination target 0, lun 0
         command: Test Unit Ready: 00 00 00 00 00 00
Unrecognized sense data (in hex):
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
scsi host busy 1 failed 0
Waking error handler thread
Error handler scsi_eh_2 waking up
ata_scsi_error: ENTER
ahci_eng_timeout: ENTER
ata1: error occurred, port reset
atapi_qc_complete: request check condition
Notifying upper driver of completion for device 0 2
ata_scsi_error: EXIT
scsi_restart_operations: waking up host to restart
Error handler scsi_eh_2 sleeping
Leaving scsi_init_cmd_from_req()
scsi_add_timer: scmd: f29f6e00, time: 30000, (f8baa860)
scsi <2:0:0:0> send 0xf29f6e00                  scsi2 : destination target 0, lun 0
         command: Test Unit Ready: 00 00 00 00 00 00
buffer = 0xc04d4e00, bufflen = 0, done = 0xf8bacae0, queuecommand 0xf8bd23d0
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 00
ata_scsi_translate: ENTER
scsi_delete_timer: scmd: f29f6e00, rtn: 1
leaving scsi_dispatch_cmnd()
scsi <2:0:0:0> done 0xf29f6e00 MLQUEUE       28 scsi2 : destination target 0, lun 0
         command: Test Unit Ready: 00 00 00 00 00 00
scsi host busy 1 failed 0
Inserting command f29f6e00 into mlqueue
scsi_delete_timer: scmd: f29f6e00, rtn: 0
scsi2 (0:0) unblocking device at zero depth
scsi_add_timer: scmd: f29f6e00, time: 30000, (f8baa860)
scsi <2:0:0:0> send 0xf29f6e00                  scsi2 : destination target 0, lun 0
         command: Test Unit Ready: 00 00 00 00 00 00
buffer = 0xc04d4e00, bufflen = 0, done = 0xf8bacae0, queuecommand 0xf8bd23d0
ata_scsi_dump_cdb: CDB (1:0,0,0) 00 00 00 00 00 00 00 00 00
ata_scsi_translate: ENTER
scsi_delete_timer: scmd: f29f6e00, rtn: 1
leaving scsi_dispatch_cmnd()
scsi <2:0:0:0> done 0xf29f6e00 MLQUEUE       28 scsi2 : destination target 0, lun 0
         command: Test Unit Ready: 00 00 00 00 00 00
scsi host busy 1 failed 0
Inserting command f29f6e00 into mlqueue
scsi_delete_timer: scmd: f29f6e00, rtn: 0
scsi2 (0:0) unblocking device at zero depth
... The Test Unit Ready keeps repeating ...

73 Eric  eac@shore.net
