From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IDE driver in polling mode
Date: Tue, 10 Apr 2007 17:11:25 +0100
Message-ID: <20070410171125.3aeed29d@the-village.bc.nu>
References: <1ea6be8e0704100635ydbf1538i782e796c99891e5d@mail.gmail.com>
	<461B9D04.2000109@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-embedded-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org>
In-Reply-To: <461B9D04.2000109@ru.mvista.com>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-embedded-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
Errors-To: linuxppc-embedded-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: linux-ide@vger.kernel.org

>     Ah, no interrupts at all...
>     The old IDE core in drivers/ide/ certainly doesn't support polling mode 
> and IRQ-less devices. AFAICS, libata also doesn't support the latter...

libata has much of the framework to do this as it originally did all of
its PIO work much this way. That is probably the most productive place to
start hacking.

Alan
