From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: 2.6.27-rc3: IP: [<ffffffffa0038b77>]
	init_irq+0x18d/0x31c	[ide_core]
Date: Thu, 21 Aug 2008 12:57:16 -0500
Message-ID: <48ADAC7C.7040003@lwfinger.net>
References: <20080820173122.GA7335@deprecation.cyrius.com>
	<48AC71D7.8050604@lwfinger.net>
	<20080821161610.GA2640@deprecation.cyrius.com>
	<48ADA743.1070000@lwfinger.net>
	<20080821175215.GI2640@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org>
In-Reply-To: <20080821175215.GI2640@deprecation.cyrius.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-pcmcia>
List-Post: <mailto:linux-pcmcia@lists.infradead.org>
List-Help: <mailto:linux-pcmcia-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=subscribe>
Sender: linux-pcmcia-bounces@lists.infradead.org
Errors-To: linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org
To: Martin Michlmayr <tbm@cyrius.com>
Cc: linux-ide@vger.kernel.org, linux-pcmcia@lists.infradead.org, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-ide@vger.kernel.org

Martin Michlmayr wrote:
> * Larry Finger <Larry.Finger@lwfinger.net> [2008-08-21 12:34]:
>> Did this work with precious versions? If so, it should be posted as
>> a  regression.
> 
> 2.6.25 and 2.6.26 work just fine.

Do you have a git tree, or have you downloaded snapshots? If the 
former, a bisection would be useful.

Larry
