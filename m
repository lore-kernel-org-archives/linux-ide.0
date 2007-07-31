From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/2] [POWERPC] MPC8349E-mITX: use platform IDE driver for
	CF	interface
Date: Wed, 1 Aug 2007 00:36:14 +0200
Message-ID: <a414f3b506b7802a717e6e2c08befd1e@kernel.crashing.org>
References: <20070725165318.5331.23795.stgit@localhost.localdomain>	<20070725165326.5331.19920.stgit@localhost.localdomain>
	<46A78322.3080607@ru.mvista.com> <46A78E3F.1030904@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <46A78E3F.1030904@ru.mvista.com>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

>>> +	ide@f0000000 {
>>> +		compatible = "mmio-ide";
>>> +		device_type = "ide";
>
>>     Why not "ata"?

The hardware is called (E)IDE, the protocol is called ATA.
Or that's what I was told -- I think there's some historic
revisionism involved, too.

>     Also, what mmio-ide in the compat properly means in the context of
> ide_platform which is able to handle both port and memory mapped IDE. 
> I think
> we must get rid with this crap, and since this IDE register mapping is 
> pretty
> much board specific, call it something like "mpc8349emitx-ide" instead.

"mmio-ide" simply is not specific enough.  The device_type
should go, too.

If this IDE interface is board-specific, thee "compatible"
property should include the board vendor name and board
name.  Oh, that's what "emitx" tries to do -- it could be
a bit clearer perhaps ;-)


Segher
