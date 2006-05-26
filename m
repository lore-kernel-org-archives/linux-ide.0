From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: [PATCH/2.6.17-rc4 10/10] bugs fix for marvell SATA on powerp c pl
	atform
Date: Fri, 26 May 2006 18:25:23 +0200
Message-ID: <20060526162523.GA13104@powerlinux.fr>
References: <446C9219.4080300@pobox.com> <446CDE26.8090504@rtr.ca>
	<20060526083931.GA23938@powerlinux.fr> <4476E964.90509@rtr.ca>
	<20060526114245.GA32330@powerlinux.fr>
	<44770065.8070907@rtr.ca> <20060526141535.GA7084@powerlinux.fr>
	<447722FF.9020202@rtr.ca> <20060526160156.GA11778@powerlinux.fr>
	<44772B10.7040300@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
Content-Disposition: inline
In-Reply-To: <44772B10.7040300@rtr.ca>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Mark Lord <liml@rtr.ca>
Cc: Alexandre.Bounine@tundra.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>, Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-ide@vger.kernel.org

On Fri, May 26, 2006 at 12:21:36PM -0400, Mark Lord wrote:
> Sven Luther wrote:
> >On Fri, May 26, 2006 at 11:47:11AM -0400, Mark Lord wrote:
> >
> >>Meanwhile, I just booted 2.6.17-rc5-git1 (latest kernel.org) on my Mac G3
> >>box here, and sata_mv seems to be behaving for me (thus far).
> >
> >Mmm, this is a G3, while i have a G4. The G4 does some I/O reordering, 
> >which
> >we don't have with a G3, so this may be the cause. 
> 
> MMmm.. is your G4 using a 64-bit kernel, or a 32-bit kernel?

Ah, no, the G4 is a 32bit processor.

> The driver is a complete unknown (for me, at least) on 64-bit systems,
> as I don't have one (of any processor type) here yet.

I have an Xserve G5, which is a 64bit powerpc machine, and i could try it in
it. I need to get the fans to a usable level first though, as it sounds like
an airplan, and is sitting right beside my desk.

> >Do you have a mac version of the board, with a forth/OF bios in it ? Or a
> >normal PC card, which is thus uninitialized ? 
> 
> The board claims to be "mac" compatible, so it probably has an OF bios on 
> it, but I have not verified this yet.

Yes, probably. This could mean that the board gets initialized for you, but
not for me.

Friendly,

Sven Luther
