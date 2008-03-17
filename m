From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] ahci: implement skip_host_reset parameter
Date: Mon, 17 Mar 2008 08:27:40 -0400
Message-ID: <47DE63BC.3060703@garzik.org>
References: <Pine.LNX.4.64.0803051143450.27209@Soyuz-KT.TeNet.Odessa.UA> <47CE9264.1010600@garzik.org> <Pine.LNX.4.64.0803051443500.28213@Soyuz-KT.TeNet.Odessa.UA> <47CFBDB6.8040400@gmail.com> <Pine.LNX.4.64.0803061417540.5200@Soyuz-KT.TeNet.Odessa.UA> <47D0BC5A.9000208@gmail.com> <Pine.LNX.4.64.0803071038380.12026@Soyuz-KT.TeNet.Odessa.UA> <47D1E91D.8090704@gmail.com> <Pine.LNX.4.64.0803081801120.23474@Soyuz-KT.TeNet.Odessa.UA> <47D371F5.1020804@gmail.com> <47D3720D.7040004@gmail.com> <Pine.LNX.4.64.0803091938210.28462@Soyuz-KT.TeNet.Odessa.UA> <47D48E05.4090001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47639 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755223AbYCQM1p (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Mar 2008 08:27:45 -0400
In-Reply-To: <47D48E05.4090001@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: "Rus V. Brushkoff" <rus@SoyuzKT.Od.UA>, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

Tejun Heo wrote:
> Under certain circumstances (SSP turned off by the BIOS) and for
> debugging purposes, skipping global controller reset is helpful.  Add
> a kernel parameter for it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/ahci.c |   48 +++++++++++++++++++++++++++++-------------------
>  1 file changed, 29 insertions(+), 19 deletions(-)

applied


