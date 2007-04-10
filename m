From: Michael <michaelzwrk@gmail.com>
Subject: Re: IDE driver in polling mode
Date: Tue, 10 Apr 2007 17:31:32 +0200
Message-ID: <1ea6be8e0704100831u6b7a62cbia0ecef82ec73f0a2@mail.gmail.com>
References: <1ea6be8e0704100635ydbf1538i782e796c99891e5d@mail.gmail.com>
	<461B9D04.2000109@ru.mvista.com> <461BA2BB.6040101@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-embedded-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org>
In-Reply-To: <461BA2BB.6040101@rtr.ca>
Content-Disposition: inline
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-embedded-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
Errors-To: linuxppc-embedded-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: linux-ide@vger.kernel.org

Thanks, looks like a good plan...

On 4/10/07, Mark Lord <liml@rtr.ca> wrote:
> > Michael wrote:
> >
> >> I'd like to know whether it is possible to use IDE driver (ide-disk)
> >> in polling mode, instead of using IRQ.
>
> This should be doable, with a small amount of hacking.
> Mostly, you just need to use add_timer() to set up a polling
> function that simply calls ide_intr() and then does add_timer()
> again for the next poll.
>
> For your purposes, it could be as simple as five lines of C.
>
> Cheers
>
