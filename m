From: Robert de Rooy <robert.de.rooy@gmail.com>
Subject: [Fwd: Re: libata and legacy ide pcmcia failure]
Date: Mon, 25 Jun 2007 21:11:30 +0200
Message-ID: <46801362.3040605@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070703090404000903000409"
Return-path: <linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-pcmcia>
List-Post: <mailto:linux-pcmcia@lists.infradead.org>
List-Help: <mailto:linux-pcmcia-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=subscribe>
Sender: linux-pcmcia-bounces@lists.infradead.org
Errors-To: linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org
To: albertl@mail.com
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, bzolnier@gmail.com, linux-pcmcia@lists.infradead.org, Kernel development list <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Mark Lord <liml@rtr.ca>, Alan <alan@lxorguk.ukuu.org.uk>
List-Id: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------070703090404000903000409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Oops had done a reply instead of a reply to all...


--------------070703090404000903000409
Content-Type: message/rfc822;
	name="Re: libata and legacy ide pcmcia failure.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="Re: libata and legacy ide pcmcia failure.eml"

Message-ID: <467FA93B.6010403@gmail.com>
Date: Mon, 25 Jun 2007 13:38:35 +0200
From: Robert de Rooy <robert.de.rooy@gmail.com>
User-Agent: Thunderbird 2.0.0.4 (Windows/20070604)
MIME-Version: 1.0
To: albertl@mail.com
Subject: Re: libata and legacy ide pcmcia failure
References: <466718B6.4080105@gmail.com> <4667B39D.209@gmail.com>
	<46685AE5.4010908@gmail.com> <466900F3.7040801@gmail.com>
	<46694FB2.6040007@pobox.com> <4669D2D8.3020806@gmail.com>
	<4669D3F5.7040300@rtr.ca> <466B4D86.1020808@gmail.com>
	<466C631D.2000001@rtr.ca> <466C723C.6000300@gmail.com>
	<20070610221322.GA18196@flint.arm.linux.org.uk>
	<466C7A9F.1080700@rtr.ca> <466DCE55.30507@gmail.com>
	<466DCF43.5060304@pobox.com> <466E11DF.5020901@gmail.com>
	<466F4A27.8070309@tw.ibm.com> <46710CD7.9070901@gmail.com>
	<467BB7DB.4090004@gmail.com> <467BCF86.8060508@rtr.ca>
	<467F3EDC.2060002@tw.ibm.com> <467F8B8B.1000006@gmail.com>
	<467F95D8.6000805@tw.ibm.com>
In-Reply-To: <467F95D8.6000805@tw.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Albert Lee wrote:
> The patch just workarounds the "lost irq" problem by polling; not real
> fix. We still need to find out why irq is lost per Mark's comment:
>
> "This proves that the device does work correctly in most respects
> except for interrupt delivery.  The status bits are working and
> it can be probed for, configured, and used."
>
> "So, next step might be to try and understand the interrupt mis-delivery
> problem some more.   I've lost the history of the original issue,
> but we now know that everything except the actual interrupt seems good."
>
> I am not familiar with the PCMCIA interrupt delivery. It seems the
> "Dazzle 4in1 Card Adapter" works under windows but somehow lost irq
> under both IDE and libata. Maybe Alan/Bart or the PCMCIA developers
> know better...
> --
> albert

I see. So this is not the ideal fix for this problem. Anything else I 
can do to debug the irq lost issue? perhaps add some debug to the pcmcia 
code?

For what its worth, I compiled a clean 2.6.22-rc5 with just the 
pio_polling patch added, and that allows me to mount the device without 
any errors in syslog. So the 
disable-dev_init_param-and-setxfermode-for-CFA.patch is not needed.



--------------070703090404000903000409
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070703090404000903000409--
