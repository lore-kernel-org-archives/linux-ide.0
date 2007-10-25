From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [2.6 patch] libata-core.c: make 2 functions static
Date: Thu, 25 Oct 2007 02:01:43 -0400
Message-ID: <47203147.7050408@garzik.org>
References: <20071024162306.GF30533@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55686 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753056AbXJYGBo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Oct 2007 02:01:44 -0400
In-Reply-To: <20071024162306.GF30533@stusta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> strn_pattern_cmp() and ata_port_detach() can become static.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
> ---
> 
>  drivers/ata/libata-core.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

applied


