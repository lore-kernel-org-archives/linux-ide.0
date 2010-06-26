From: Tejun Heo <tj@kernel.org>
Subject: Re: ata link not reset properly
Date: Sat, 26 Jun 2010 10:03:40 +0200
Message-ID: <4C25B45C.9080805@kernel.org>
References: <4C223F8A.9030306@odi.ch> <4C224429.6010705@kernel.org> <4C224502.2040206@kernel.org> <4C2305A8.4070708@odi.ch> <4C24C903.1070705@kernel.org> <4C24EED2.4020300@odi.ch> <4C257CEE.2070309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C257CEE.2070309@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: =?ISO-8859-1?Q?Ortwin_Gl=FCck?= <odi@odi.ch>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello,

On 06/26/2010 06:07 AM, Robert Hancock wrote:
> Ahh, ok, it's not sata_nv at all then, it's pata_amd. On the same chip,
> totally different controller though.
> 
> PATA doesn't normally use hard-resets as a means of error recovery -
> that would mean hitting the RESET line, which I don't think most
> controllers can do on software command (it usually only gets asserted on
> power up or hitting the reset button), unlike on SATA where there's a
> defined way to trigger a COMRESET which is mostly equivalent. Also, that
> resets both devices on the channel, unlike soft reset which is specific
> to one device.

Yeah, if it's pata_amd and SRST isn't recovering the device, there
isn't much else to do.  :-(

Thanks.

-- 
tejun
