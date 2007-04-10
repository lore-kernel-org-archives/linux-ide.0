From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IDE driver in polling mode
Date: Tue, 10 Apr 2007 17:29:42 +0100
Message-ID: <20070410172942.7f63d49c@the-village.bc.nu>
References: <1ea6be8e0704100635ydbf1538i782e796c99891e5d@mail.gmail.com>
	<461B9D04.2000109@ru.mvista.com>
	<20070410171125.3aeed29d@the-village.bc.nu>
	<461BB8C7.9050900@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-embedded-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org>
In-Reply-To: <461BB8C7.9050900@garzik.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-embedded-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
Errors-To: linuxppc-embedded-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: linux-ide@vger.kernel.org

> The only real restriction in libata is in ata_device_add(), which 
> unconditionally registers an irq handler.  Make a few changes there, add 
> a few flags, and the existing polling code will kick in.

Obvious thing to do would be to do this if the IRQ number passed in is 0
rather than aborting as we do now. In theory ISAPnP devices may be
IRQless too.

Alan
