From: "Jonas Petersson" <jonas.petersson@xms.se>
Subject: Re: exception Emask 0x0 SAct 0x0 SErr 0x0
 action 0x2 frozen
Date: Sun, 07 Sep 2008 22:48:48 +0200
Message-ID: <48C43E30.6020504@xms.se>
References: <48B91198.3020803@xms.se><alpine.DEB.1.10.0808300708330.19513@p34.internal.lan><48B9AE15.7010605@xms.se><alpine.DEB.1.10.0808301710380.11166@p34.internal.lan><48B9C261.4010609@xms.se>
	<alpine.DEB.1.10.0808301804290.11166@p34.internal.lan>
	<FAF797E46D786344A7C36218608F791C01F3ABA5@mail1.netezza.com>
	<48BD6086.1030101@xms.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <smartmontools-support-bounces@lists.sourceforge.net>
In-Reply-To: <48BD6086.1030101@xms.se>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/smartmontools-support>,
	<mailto:smartmontools-support-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=smartmontools-support>
List-Post: <mailto:smartmontools-support@lists.sourceforge.net>
List-Help: <mailto:smartmontools-support-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/smartmontools-support>,
	<mailto:smartmontools-support-request@lists.sourceforge.net?subject=subscribe>
Sender: smartmontools-support-bounces@lists.sourceforge.net
Errors-To: smartmontools-support-bounces@lists.sourceforge.net
Cc: linux-ide@vger.kernel.org, smartmontools-support@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

For the record:

Jonas Petersson wrote:
> Owen Martin wrote:
>  > This looks like a timeout during a read command:
>  >
>  > ata3.00: cmd c8/00:08:90:3c:59
>  >
>  > Read dma of 8 blocks from 0x903c59
>  >
>  > Next time it happens, see if it is the same LBA. Since the drive came
>  > back after the bus reset makes me think it was probably in error
>  > recovery for an extended amount of time.
> 
> Sounds like a good idea. However, I had the drive swapped yesterday and 
> have now reinstalled on a (seemingly) identical one which so far seems 
> to be free from these messages. Hence, I keep my fingers crossed that 
> this was indeed a hw error.
 > [...]

I've now stressed the new disk for almost a week and seen no indication 
at all to the previous error. Everything else is the same as before - I 
even installed from the very same DVD. My conclusion is therefore that I 
really had a disk that was broken in a way that normal tests will not 
detect.

Hence, my tip to anyone having a similar experience: Don't blame the 
driver, nor the motherboard/chipset - just replace the drive. It would 
of course be even nicer if the error message could spell this out 
somewhat clearer too, but I guess the "I/O error" in the middle is a 
fair hint in retrospect.

			Best / Jonas



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
