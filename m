From: Brad Campbell <brad@wasp.net.au>
Subject: Re: libata oops 2.6.11-rc4 yesterdays BK
Date: Wed, 16 Feb 2005 15:01:23 +0400
Message-ID: <42132803.2080701@wasp.net.au>
References: <4212CBD6.7020703@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from wasp.net.au ([203.190.192.17]:34228 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S262003AbVBPLBd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Feb 2005 06:01:33 -0500
In-Reply-To: <4212CBD6.7020703@wasp.net.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Brad Campbell wrote:
> Woke up to this, this morning.
> This is yesterdays 2.6.11-rc4 BK + libata BK + libata-dev BK
> It was in the middle of a RAID-6 rebuild (scheduled to take about 740 
> minutes)
> 

Oh well, it appears to be reproducible anyway!

Regards,
Brad

ata15: status=0x51 { DriveReady SeekComplete Error }
ata15: called with no error (51)!
------------[ cut here ]------------
kernel BUG at drivers/scsi/scsi.c:299!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c0257a0b>]    Not tainted VLI
EFLAGS: 00010046   (2.6.11-rc4)
EIP is at scsi_put_command+0x8b/0xa0
eax: ddaf85c0   ebx: ddaf85c0   ecx: ddaf85d0   edx: ddaf85d0
esi: dfc70000   edi: 00000292   ebp: dfc66400   esp: dfcabe7c
ds: 007b   es: 007b   ss: 0068
Process scsi_eh_14 (pid: 799, threadinfo=dfcaa000 task=dfc73a20)
Stack: df945f58 dfcc6200 dfc65a28 ddaf85c0 00000296 dfc65a28 c025c859 ddaf85c0
        df945f58 c025c97f ddaf85c0 00000001 00000000 ddaf85c0 ddaf85c0 00000004
        ddaf867c c025ccfe ddaf85c0 00000001 00000000 00000000 000057a8 000057a8
Call Trace:
  [<c025c859>] scsi_next_command+0x19/0x30
  [<c025c97f>] scsi_end_request+0xbf/0xe0
  [<c025ccfe>] scsi_io_completion+0x1ae/0x490
  [<c026927b>] sd_rw_intr+0xcb/0x280
  [<c02580ea>] scsi_finish_command+0x7a/0xc0
  [<c0266ad9>] ata_scsi_qc_complete+0x39/0x70
  [<c026460a>] ata_qc_complete+0x3a/0xc0
  [<c0267e30>] pdc_eng_timeout+0x90/0x120
  [<c026663a>] ata_scsi_error+0x1a/0x30
  [<c025bd4e>] scsi_error_handler+0x9e/0xe0
  [<c025bcb0>] scsi_error_handler+0x0/0xe0
  [<c0100831>] kernel_thread_helper+0x5/0x14
Code: 5c 24 08 8b 74 24 0c 89 44 24 1c 8b 7c 24 10 8b 6c 24 14 83 c4 18 e9 e5 15
  fd ff 89 43 10 89 48 04 31 db 89 51 04 89 4e 0c eb b7 <0f> 0b 2b 01 e7 1a 32 c0
  eb 95 8d 74 26 00 8d bc 27 00 00 00 00
  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
  printing eip:
c01333c3
*pde = 00000000
Oops: 0000 [#2]
CPU:    0
EIP:    0060:[<c01333c3>]    Not tainted VLI
EFLAGS: 00010016   (2.6.11-rc4)
EIP is at free_block+0x43/0xd0
eax: 00800000   ebx: 00000000   ecx: 00000000   edx: c1000000
esi: c1506d60   edi: 00000000   ebp: c1506d6c   esp: c14e9ef0
ds: 007b   es: 007b   ss: 0068
Process events/0 (pid: 3, threadinfo=c14e8000 task=c14da020)
Stack: c14da020 dffe69f0 c1506d7c dff08b70 dff08b60 00000001 c1506d60 c0133a0a
        c1506d60 dff08b70 00000001 c1506d60 00000001 c1506dd0 c1506a7c c0133aaa
        c1506d60 dff08b60 00000000 c14da170 00000293 00000000 c051fca4 c0133a50
Call Trace:
  [<c0133a0a>] drain_array_locked+0x7a/0xc0
  [<c0133aaa>] cache_reap+0x5a/0x150
  [<c0133a50>] cache_reap+0x0/0x150
  [<c012326e>] worker_thread+0x19e/0x240
  [<c0111b50>] default_wake_function+0x0/0x20
  [<c0111b50>] default_wake_function+0x0/0x20
  [<c01230d0>] worker_thread+0x0/0x240
  [<c0126ae5>] kthread+0xa5/0xb0
  [<c0126a40>] kthread+0x0/0xb0
  [<c0100831>] kernel_thread_helper+0x5/0x14
Code: 83 00 00 00 8d 46 1c 8d 6e 0c 89 44 24 08 8b 44 24 24 8b 15 b0 fd 51 c0 8b
  0c b8 8d 81 00 00 00 40 c1 e8 0c c1 e0 05 8b 5c 02 1c <8b> 53 04 8b 03 89 50 04
  89 02 c7 43 04 00 02 20 00 2b 4b 0c c7



-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
