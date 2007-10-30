From: Yanping Du <ypdu2001@yahoo.com>
Subject: question on patch: ide: do_identify() string termination fix [PATCH 2.6.11-rc2 08/29]
Date: Tue, 30 Oct 2007 15:00:16 -0700 (PDT)
Message-ID: <987926.65237.qm@web55214.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web55214.mail.re4.yahoo.com ([206.190.58.178]:44521 "HELO
	web55214.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751767AbXJ3WG5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 18:06:57 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

  We hit an NMI watchdog on cpu lockup (trace below)
and I suspect it might be related to following string
termination bug. However I wonder why this bug fix is
not incorporated in latest mainline kernel (2.6.23.1
as I checked). The bug fix seems straightforward to
me. Did I miss anything ? Our kernel is 2.6.12.

http://osdir.com/ml/ide/2005-02/msg00038.html

Thanks!
-Yanping


> 08_ide_do_identify_model_string_termination.patch
> 
>       Terminates id->model string before invoking
strstr() in
>       do_identify().
Signed-off-by: Tejun Heo <tj@xxxxxxxxxxx>


Index: linux-ide-export/drivers/ide/ide-probe.c
===================================================================
--- linux-ide-export.orig/drivers/ide/ide-probe.c     
 2005-02-02 
10:27:15.858207205 +0900
+++ linux-ide-export/drivers/ide/ide-probe.c   
2005-02-02 10:28:03.719442099 
+0900
@@ -165,11 +165,12 @@ static inline void do_identify
(ide_driv
        ide_fixstring(id->fw_rev,   
sizeof(id->fw_rev),    bswap);
        ide_fixstring(id->serial_no,
sizeof(id->serial_no), bswap);
 
+       /* we depend on this a lot! */
+       id->model[sizeof(id->model)-1] = '\0';
+
        if (strstr(id->model, "E X A B Y T E N E S
T"))
                goto err_misc;
 
-       /* we depend on this a lot! */
-       id->model[sizeof(id->model)-1] = '\0';
        printk("%s: %s, ", drive->name, id->model);
        drive->present = 1;
        drive->dead = 0;


Our trace:

    285 <6>[       161.531535] ide: Assuming 33MHz
system bus speed for PIO modes; override with
idebus=xx
    286 <7>[       161.627836] Probing IDE interface
ide0...
    287 <4>[       161.960435] hda: PQI IDE
DiskOnModule, <4>warning: many lost ticks.
    288 <4>[       161.974888] Your time source seems
to be instable or some driver is hogging interupts
    289 <4>[      2063.364028] NMI Watchdog detected
LOCKUP on CPU3CPU 3
    290 <4>[      2063.551159] Modules linked in:
    291 <4>[      2063.590737] Pid: 1, comm: swapper
Not tainted 2.6.12-ddr48115
    292 <4>[      2063.661075] RIP:
0010:[<ffffffff8039c825>]
<ffffffff8039c825>{.text.lock.spinlock+14}
    293 <4>[      2063.755159]
    294 <4>[      2063.755159] RSP:
0018:ffff8100155fbb18  EFLAGS: 00000086
    295 <4>[      2063.842405] RAX: 0000000000000000
RBX: 00000000000046c9 RCX: 0000000000000000
    296 <4>[      2063.928570] RDX: 00000000000003f9
RSI: 0000000000000001 RDI: ffffffff8049a3c0
    297 <4>[      2064.014742] RBP: 00000000000046c9
R08: 0000000000000000 R09: 0000000000000000
    298 <4>[      2064.100906] R10: ffff8100155fb418
R11: 00000000000000e8 R12: 000000000000469a
    299 <4>[      2064.187073] R13: 0000000000000296
R14: ffffffffffffb937 R15: 000000000000002f
    300 [3]more>
    301 <4>[      2064.273244] FS: 
0000000000000000(0000) GS:ffffffff806a5800(0000)
knlGS:0000000000000000
    302 <4>[      2064.370289] CS:  0010 DS: 0018 ES:
0018 CR0: 000000008005003b
    303 <4>[      2064.440625] CR2: 00000000007b18dc
CR3: 0000000000101000 CR4: 00000000000006e0
    304 <4>[      2064.526794] Process swapper (pid:
1, threadinfo ffff8100155fa000, task ffff81009fa20740)
    305 <4>[      2064.623841] Stack: 0000000000000296
ffffffff801367cc ffff8100155fbb7f ffff8100155fbb7f
    306 <4>[      2064.717829]        0000000000000032
ffffffff80616e3b 0000000000000017 ffffffff80136d22
    307 <4>[      2064.813800]        000000000009947c
0000000000000296 Call Trace:
    308 <4>[      2064.888993]
<ffffffff801367cc>{release_console_sem+28}
    309 <4>[      2064.952398]
<ffffffff80136d22>{vprintk+914}
    310 <4>[      2065.004926]
<ffffffff80251825>{vsnprintf+757}
    311 <4>[      2065.059433]
<ffffffff80136d22>{vprintk+914}
    312 <4>[      2065.111965]
<ffffffff8039b0d7>{thread_return+0}
    313 <4>[      2065.168453]
<ffffffff8039b24a>{thread_return+371}
    314 <4>[      2065.226915]
<ffffffff80136ddd>{printk+141}
    315 <4>[      2065.278452]
<ffffffff8013f895>{del_singleshot_timer_sync+21}
    316 <4>[      2065.347801]
<ffffffff8039be3e>{schedule_timeout+270}
    317 <4>[      2065.409235]
<ffffffff80140200>{process_timeout+0}
    318 <4>[      2065.467700]
<ffffffff80251088>{strstr+72}
    319 <4>[      2065.518250]
<ffffffff802d33ec>{try_to_identify+620}
    320 <4>[      2065.578694]
<ffffffff802d384c>{do_probe+268}
    321 <4>[      2065.632210]
<ffffffff80252fc8>{__delay+8}
    322 <4>[      2065.682757]
<ffffffff8025300a>{__const_udelay+42}
    323 <4>[      2065.741220]
<ffffffff802d3e32>{probe_hwif+866}
    324 [3]more>
    325 Only 'q' or 'Q' are processed at more prompt,
input ignored
    326 <4>[      2065.796714]
<ffffffff802d5098>{ideprobe_init+88}
    327 <4>[      2065.854186]
<ffffffff801b8da2>{create_proc_entry+146}
    328 <4>[      2065.916609]
<ffffffff806d0f79>{ide_generic_init+9}
    329 <4>[      2065.976060]
<ffffffff8010c259>{init+505}
    330 <4>[      2066.025620]
<ffffffff8010f7ab>{child_rip+8}
    331 <4>[      2066.078145]
<ffffffff8010c060>{init+0}
    332 <4>[      2066.125726]
<ffffffff8010f7a3>{child_rip+0}
    333 <4>[      2066.178256]


Yanping Du
Software Engineer, Cisco Systems
820 Alder Dr.
Milpitas, CA 95035
Tel: 408-525-3929 (o)

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
