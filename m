From: Willy Gardiol <gardiol@libero.it>
Subject: Re: Bug in IDE controllers when connected to PCI?
Date: Tue, 31 Dec 2002 09:31:15 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200212310931.20646.gardiol@libero.it>
References: <200303121221.11335.gardiol@libero.it> <200303121313.h2CDDmu29857@Port.imtp.ilyichevsk.odessa.ua>
Reply-To: gardiol@libero.it
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_UXVE+Kzdi+OlNcM"
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <200303121313.h2CDDmu29857@Port.imtp.ilyichevsk.odessa.ua>
List-Id: linux-ide@vger.kernel.org
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk


--Boundary-00=_UXVE+Kzdi+OlNcM
Content-Type: Text/Plain;
  charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Content-Description: clearsigned data
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> Although it will take some time, please write down
> oops (or hook up a serial console and catch it on second box),
> decode it with ksymoops and send to lkml and to IDE folks, most
> notably Alan. This will give them much more info.
> --
> vda

I did it, and now have the oops decoded.
To who must i send it, besides this list and Alan?

Attached, there are two oops decoded, these oops occours when i try to enab=
le=20
DMA and burn with my burner only when connected to a PCI IDE controller
(others also reports DMA data corruption on similar configuration)



=2D --=20

!=20
 Willy Gardiol - gardiol@libero.it
 goemon.polito.it/~gardiol
 Use linux for your freedom.

   "Tutti hanno dei pregiudizi, solo=20
    che i nostri sono giusti."

      Stefano Bagnasco  (2002)

=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+EVXYQ9qolN/zUk4RAotlAJ9lBIWXVw8TtveX+IqLS0YGG7DD3wCghIyP
Tha6BbnxKZMj1Opjj46oRzo=3D
=3DOR+7
=2D----END PGP SIGNATURE-----

--Boundary-00=_UXVE+Kzdi+OlNcM
Content-Type: text/x-log;
  charset="koi8-r";
  name="ide-ops1.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ide-ops1.log"

ksymoops 2.4.5 on i686 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

cpu: 0, clocks: 2018139, slice: 1009069
Unable to handle kernel NULL pointer dereference at virtual address 00000018
c02093eb
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c02093eb>]    Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210282
eax: c15d6dc0   ebx: c0348428   ecx: dfaab240   edx: dfaab240
esi: 00000000   edi: c0348428   ebp: 00000000   esp: d9415e40
ds: 0018   es: 0018   ss: 0018
Process gkrellm (pid: 614, stackpage=d9415000)
Stack: c01e783c 000003e8 c15d0d80 c0108aae c15d6dc0 00000000 00000040 c0348428 
       c03482a8 c01e7c2a c0348428 00000000 00000000 00000088 000001f4 00000000 
       c03482a8 dfaab240 00000000 00000018 c0348428 c15f3280 c03482a8 dfaab240 
Call Trace:    [<c01e783c>] [<c0108aae>] [<c01e7c2a>] [<c01e7e25>] [<c01e810b>]
  [<c01e8020>] [<c01236fe>] [<c011fb02>] [<c011fa16>] [<c011f854>] [<c0108aae>]
  [<c010b018>] [<c0150a11>] [<c0139d5a>] [<c0139dee>] [<c0107373>]
Code: 8b 56 18 89 70 04 8b 46 1c 8b 7e 0c c7 46 10 00 00 00 00 89 


>>EIP; c02093eb <idescsi_issue_pc+1b/1b0>   <=====

>>eax; c15d6dc0 <_end+128484c/204c0a8c>
>>ebx; c0348428 <ide_hwifs+808/20a8>
>>ecx; dfaab240 <_end+1f758ccc/204c0a8c>
>>edx; dfaab240 <_end+1f758ccc/204c0a8c>
>>edi; c0348428 <ide_hwifs+808/20a8>
>>esp; d9415e40 <_end+190c38cc/204c0a8c>

Trace; c01e783c <ide_wait_stat+bc/130>
Trace; c0108aae <do_IRQ+9e/a0>
Trace; c01e7c2a <start_request+1ba/260>
Trace; c01e7e25 <ide_do_request+c5/1c0>
Trace; c01e810b <ide_timer_expiry+eb/1c0>
Trace; c01e8020 <ide_timer_expiry+0/1c0>
Trace; c01236fe <run_timer_list+ee/170>
Trace; c011fb02 <bh_action+22/40>
Trace; c011fa16 <tasklet_hi_action+46/70>
Trace; c011f854 <do_softirq+94/a0>
Trace; c0108aae <do_IRQ+9e/a0>
Trace; c010b018 <call_do_IRQ+5/d>
Trace; c0150a11 <dnotify_flush+21/a0>
Trace; c0139d5a <filp_close+3a/80>
Trace; c0139dee <sys_close+4e/60>
Trace; c0107373 <system_call+33/38>

Code;  c02093eb <idescsi_issue_pc+1b/1b0>
00000000 <_EIP>:
Code;  c02093eb <idescsi_issue_pc+1b/1b0>   <=====
   0:   8b 56 18                  mov    0x18(%esi),%edx   <=====
Code;  c02093ee <idescsi_issue_pc+1e/1b0>
   3:   89 70 04                  mov    %esi,0x4(%eax)
Code;  c02093f1 <idescsi_issue_pc+21/1b0>
   6:   8b 46 1c                  mov    0x1c(%esi),%eax
Code;  c02093f4 <idescsi_issue_pc+24/1b0>
   9:   8b 7e 0c                  mov    0xc(%esi),%edi
Code;  c02093f7 <idescsi_issue_pc+27/1b0>
   c:   c7 46 10 00 00 00 00      movl   $0x0,0x10(%esi)
Code;  c02093fe <idescsi_issue_pc+2e/1b0>
  13:   89 00                     mov    %eax,(%eax)

 <0>Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.

--Boundary-00=_UXVE+Kzdi+OlNcM
Content-Type: text/x-log;
  charset="koi8-r";
  name="ide-ops2.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ide-ops2.log"

cpu: 0, clocks: 2018136, slice: 1009068
cpu: 0, clocks: 2017929, slice: 1008964
Unable to handle kernel NULL pointer dereference at virtual address 00000018
c02093eb
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c02093eb>]    Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013286
eax: c15d6dc0   ebx: c0348428   ecx: dc756f40   edx: dc756f40
esi: 00000000   edi: c0348428   ebp: 00000000   esp: c0301e90
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0301000)
Stack: c01e783c 000003e8 da246b40 c0108aae c15d6dc0 00000000 00000040 c0348428 
       c03482a8 c01e7c2a c0348428 00000000 00000000 00000088 000001f4 00000000 
       c03482a8 dc756f40 00000000 00000018 c0348428 c15f3280 c03482a8 dc756f40 
Call Trace:    [<c01e783c>] [<c0108aae>] [<c01e7c2a>] [<c01e7e25>] [<c01e810b>]
  [<c01e8020>] [<c01236fe>] [<c011fb02>] [<c011fa16>] [<c011f854>] [<c0108aae>]
  [<c0105360>] [<c010b018>] [<c0105360>] [<c0105383>] [<c01053f2>] [<c0105000>]
Code: 8b 56 18 89 70 04 8b 46 1c 8b 7e 0c c7 46 10 00 00 00 00 89 


>>EIP; c02093eb <idescsi_issue_pc+1b/1b0>   <=====

>>eax; c15d6dc0 <_end+128484c/204c0a8c>
>>ebx; c0348428 <ide_hwifs+808/20a8>
>>ecx; dc756f40 <_end+1c4049cc/204c0a8c>
>>edx; dc756f40 <_end+1c4049cc/204c0a8c>
>>edi; c0348428 <ide_hwifs+808/20a8>
>>esp; c0301e90 <init_task_union+1e90/2000>

Trace; c01e783c <ide_wait_stat+bc/130>
Trace; c0108aae <do_IRQ+9e/a0>
Trace; c01e7c2a <start_request+1ba/260>
Trace; c01e7e25 <ide_do_request+c5/1c0>
Trace; c01e810b <ide_timer_expiry+eb/1c0>
Trace; c01e8020 <ide_timer_expiry+0/1c0>
Trace; c01236fe <run_timer_list+ee/170>
Trace; c011fb02 <bh_action+22/40>
Trace; c011fa16 <tasklet_hi_action+46/70>
Trace; c011f854 <do_softirq+94/a0>
Trace; c0108aae <do_IRQ+9e/a0>
Trace; c0105360 <default_idle+0/30>
Trace; c010b018 <call_do_IRQ+5/d>
Trace; c0105360 <default_idle+0/30>
Trace; c0105383 <default_idle+23/30>
Trace; c01053f2 <cpu_idle+42/60>
Trace; c0105000 <_stext+0/0>

Code;  c02093eb <idescsi_issue_pc+1b/1b0>
00000000 <_EIP>:
Code;  c02093eb <idescsi_issue_pc+1b/1b0>   <=====
   0:   8b 56 18                  mov    0x18(%esi),%edx   <=====
Code;  c02093ee <idescsi_issue_pc+1e/1b0>
   3:   89 70 04                  mov    %esi,0x4(%eax)
Code;  c02093f1 <idescsi_issue_pc+21/1b0>
   6:   8b 46 1c                  mov    0x1c(%esi),%eax
Code;  c02093f4 <idescsi_issue_pc+24/1b0>
   9:   8b 7e 0c                  mov    0xc(%esi),%edi
Code;  c02093f7 <idescsi_issue_pc+27/1b0>
   c:   c7 46 10 00 00 00 00      movl   $0x0,0x10(%esi)
Code;  c02093fe <idescsi_issue_pc+2e/1b0>
  13:   89 00                     mov    %eax,(%eax)

 <0>Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.

--Boundary-00=_UXVE+Kzdi+OlNcM--

