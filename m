From: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: LibPATA code issues / 2.6.16 (previously,
 2.6.15.x)
Date: Sat, 22 Apr 2006 12:39:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604221238370.2724@p34>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com>
 <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca>
 <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca>
 <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca>
 <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com>
 <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com>
 <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com> <44046CE6.60803@rtr.ca>
 <44046D86.7050809@pobox.com> <4405DCAF.6030500@dgreaves.com> <4405DDEA.7020309@rtr.ca>
 <4405E42B.9040804@dgreaves.com> <4405E83D.9000906@rtr.ca> <4405EC94.2030202@dgreaves.com>
 <4405FAAE.3080705@dgreaves.com> <Pine.LNX.4.64.0603050637110.30164@p34>
 <Pine.LNX.4.64.0603050740500.3116@p34> <440B6CFE.4010503@rtr.ca>
 <440B76B4.5080502@pobox.com> <Pine.LNX.4.64.0604211511120.22768@p34>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <smartmontools-support-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.64.0604211511120.22768@p34>
Sender: smartmontools-support-admin@lists.sourceforge.net
Errors-To: smartmontools-support-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/smartmontools-support>,
	<mailto:smartmontools-support-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:smartmontools-support@lists.sourceforge.net>
List-Help: <mailto:smartmontools-support-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/smartmontools-support>,
	<mailto:smartmontools-support-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=smartmontools-support>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <lkml@rtr.ca>, David Greaves <david@dgreaves.com>, Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, albertcc@tw.ibm.com, axboe@suse.de, Linus Torvalds <torvalds@osdl.org>, smartmontools-support@lists.sourceforge.net
List-Id: linux-ide@vger.kernel.org

Thanks for all the responses,

RMA'd the drive, will test replacement in same manner once it arrives- in 
1-2 weeks.

Justin.

On Fri, 21 Apr 2006, Justin Piszcz wrote:

> Yet a new problem, under 2.6.16, when I fill up the disk, smartmontools 
> reports this:
>
> Apr 21 14:24:20 p34 smartd[1443]: Device: /dev/sdc, 1 Currently unreadable
> (pending) sectors
> Apr 21 14:54:20 p34 smartd[1443]: Device: /dev/sdc, 1 Currently unreadable
> (pending) sectors
> Apr 21 14:54:20 p34 smartd[1443]: Device: /dev/sdc, 1 Offline uncorrectable
> sectors
>
> What made it error under 2.6.16?
>
> $ time dd if=/dev/zero of=file.out
> dd: writing to `file.out': No space left on device
> 781118873+0 records in
> 781118872+0 records out
> 399932862464 bytes (400 GB) copied, 8873.06 seconds, 45.1 MB/s
>
> real    147m53.092s
> user    8m1.395s
> sys     42m4.500s
>
> $
>
> Under 2.6.15.x, I did not see this behavior, is this going bad, or?
>
> Thanks,
>
> Justin.
>
>
>
> -------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Smartmontools-support mailing list
> Smartmontools-support@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/smartmontools-support
>


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
