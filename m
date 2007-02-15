From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] add delay around sl82c105_reset_engine calls
Date: Thu, 15 Feb 2007 18:09:31 -0500
Message-ID: <45D4E82B.7020403@garzik.org>
References: <20070210203512.GA25586@aepfle.de>
	<20070210203614.GA25602@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20070210203614.GA25602@aepfle.de>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Olaf Hering <olaf@aepfle.de>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Olaf Hering wrote:
> The hald media changed polling does really confuse things.
> Noone knows why the delays are needed, but they give us access to the CD.
> 
> An udelay(50) will give reliable access to the drive, but there is still
> one (or more) EH reset. The drive works without EH resets with udelay(100).
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> 
> ---
>  drivers/ata/pata_sl82c105.c |    3 +++
>  1 file changed, 3 insertions(+)

applied
