From: Mark Lord <liml@rtr.ca>
Subject: Re: libata and legacy ide pcmcia failure
Date: Sun, 10 Jun 2007 18:26:39 -0400
Message-ID: <466C7A9F.1080700@rtr.ca>
References: <466718B6.4080105@gmail.com> <4667B39D.209@gmail.com>
	<46685AE5.4010908@gmail.com> <466900F3.7040801@gmail.com>
	<46694FB2.6040007@pobox.com> <4669D2D8.3020806@gmail.com>
	<4669D3F5.7040300@rtr.ca> <466B4D86.1020808@gmail.com>
	<466C631D.2000001@rtr.ca> <466C723C.6000300@gmail.com>
	<20070610221322.GA18196@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org>
In-Reply-To: <20070610221322.GA18196@flint.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-pcmcia>
List-Post: <mailto:linux-pcmcia@lists.infradead.org>
List-Help: <mailto:linux-pcmcia-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=subscribe>
Sender: linux-pcmcia-bounces@lists.infradead.org
Errors-To: linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org
To: Robert de Rooy <robert.de.rooy@gmail.com>, Mark Lord <lkml@rtr.ca>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, bzolnier@gmail.com, linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org, Mark Lord <mlord@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-ide@vger.kernel.org

Russell King wrote:
> On Sun, Jun 10, 2007 at 11:50:52PM +0200, Robert de Rooy wrote:
>> Mark Lord wrote:
>>> Well, at this point, I think the only way to make progress is for one of
>>> the IDE/libata gurus to actually get hold of the same card you have,
>>> meaning Alan Cox (best choice), or myself, or Bart.  Or maybe Tejun.
>>>
>>> Without that, this isn't likely to improve much. 
>>> Cheers
>>>
>> Yeah, I was figuring it was going to come to this.
>> I hardly ever use the adapter, as I have other means to read these 
>> memory cards.
>>
>> So... Alan, want to receive a PCMCIA memory-card adapter? I will include 
>> a 16MB sony memorystick, so it actually works.
>> If so, send me your mailing address privately.
> 
> Before you do, it might help to build the ide-disk module and insert that
> as well?

ARrrggghh!!  Of course, that would explain the utter lack
of disk partition check messages, now wouldn't it!

Thanks Russell !
