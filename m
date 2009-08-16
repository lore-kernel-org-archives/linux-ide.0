From: "Subbrathnam, Swaminathan" <swami.iyer-l0cyMroinI0@public.gmane.org>
Subject: RE: sata AHCI controller over non-PCI bus
Date: Sun, 16 Aug 2009 20:05:47 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F4E077E1@dbde02.ent.ti.com>
References: <FCCFB4CDC6E5564B9182F639FC35608702F5989152@dbde02.ent.ti.com>
	<4A7FE245.8020002@ru.mvista.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F59891CB@dbde02.ent.ti.com>,
	<4A88014D.9060309@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <4A88014D.9060309-o2qLIJkoznsdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Jeff Garzik <jeff-o2qLIJkoznsdnm+yROfE0A@public.gmane.org>
Cc: "linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

Jeff,

I can work on the seperation aspects as I need to get the OMAPL138 SATA sol=
ution working.  I will try to provide a basic implementation by end of this=
 week.  Pl. provide your feedback on the same if we need to further refine =
it to address broad use cases.

Thanks for your response.

regards
swami

________________________________________
From: Jeff Garzik [jeff-o2qLIJkoznsdnm+yROfE0A@public.gmane.org]
Sent: Sunday, August 16, 2009 6:23 PM
To: Subbrathnam, Swaminathan
Cc: Sergei Shtylyov; linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; LKML
Subject: Re: sata AHCI controller over non-PCI bus

Subbrathnam, Swaminathan wrote:
> Jeff,
>       From the below link (from Sergei) it seems that you have already re=
-factored the AHCI implementation dependency on PCI.  I would like to add s=
upport for the OMAPL138 SATA on top of your changes.  That would be the ide=
al way forward for me.
>
>       Have the ahci re-factoring changes queued for mainline merge alread=
y?  I just joined the list and hence do not know the status.
>
> Sergei,
>       Appreciate the response.

I store the refactoring in git, on the "libahci" branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

Unfortunately, I am having second thoughts about an element of the
current design.  With current Linux distributions, they do not appear to
deal well with the multi-module dependency libata -> libahci -> ahci.
If I had to guess, I would say that mkinitrd creation tools only look at
one tree level's worth of kernel module dependencies.

Thus, ahci would wind up -not- in initrd, in a libahci solution.

I am thinking that I will just add Marvell and ATP support to ahci.c,
and let someone else deal with libahci separation -- which is still needed.

At this point, I would rather get Marvell/ATP support into users' hands,
rather than wait for distros to catch up to modern technology.

        Jeff=
