From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.30-rc2 2/2] palm_bk3710:  UDMA performance fix
Date: Tue, 21 Apr 2009 03:28:50 -0700
Message-ID: <200904210328.50482.david-b@pacbell.net>
References: <200904201841.10989.david-b@pacbell.net>
	<49ED99AE.3020100@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <49ED99AE.3020100-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Cc: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, DaVinci <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Bartlomiej Zolnierkiewicz <bzolnier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On Tuesday 21 April 2009, Sergei Shtylyov wrote:
> David Brownell wrote:
> 
> > Fix UDMA throughput bug:  tCYC averages t2CYCTYP/2, but the code
> > previously assumed it was the same as t2CYCTYP.
> 
>     Wow, thanks for finding it!
>     IIUC however, this should have only affected UDMA writes, not reads 
> because on reads the device controls the strobe timing.

Odd, I certainly noticed UDMA *read* performance changes...

 
> > (That is, it was using just one clock edge, not both.)
> 
>     There's no way only one clock edge could have been used since it would 
> have resulted in CRC errors, so this comment is not to the point.

That's correct of course ... better to say instead that the
throughput is exactly half what it should have been, since
the clock was using the wrong period.


> > On one system this change increased throughput by almost 4x: UDMA/66
> > sometimes topped 23 MB/sec (on a drive known to do much better).  On
> > another system it was around a 10% win (UDMA/66 up to 7+ MB/sec).
> 
>     It's interesting that on my DM6467 EVM UDMA/66 reads topped at about 29-30 
> MB/s even without this patch (measuread with hdparm), and on DM6446 EVM they 
> were only slightly slower...

I've yet to see transfer rates that fast.  Even drives that have
topped 40 MB/sec on a PC don't get that speed.


> > The difference might be caused by the ratio between memory and IDE
> > clocks.  In the system with large speedup, this was exactly 2 (as a
> > workaround for a rev 1.1 silicon bug).  The other system used a more
> > standard ratio of 1.63 (and rev 2.1 silicon) ... clock domain synch
> > might have some issues, they're not unheard-of.
> 
>     Interesting...

Yeah, but not what I'd call conclusive.  The two drives in question
were both TravelStars ... one older 20 MByte, and a less old 60 MByte.
So i have no reason to think either would have trouble going "fast".

 
> > Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> 
>     The patch itself is:
> 
> Acked-by: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
> 
> MBR, Sergei
> 
> 
