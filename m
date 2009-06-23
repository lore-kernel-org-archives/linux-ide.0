From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH v2] [libata] beautify module parameters
Date: Tue, 23 Jun 2009 01:55:56 -0400
Message-ID: <4A406E6C.1000002@pobox.com>
References: <4A3EF5B3.1040500@pobox.com> <1245656780-5688-1-git-send-email-sargentd@die-welt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47963 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757291AbZFWFzp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Jun 2009 01:55:45 -0400
In-Reply-To: <1245656780-5688-1-git-send-email-sargentd@die-welt.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Evgeni Golov <sargentd@die-welt.net>
Cc: linux-ide@vger.kernel.org

Evgeni Golov wrote:
> 1. add defaults to description where possible
> 2. add value definition (off=0, on=1) where missing
> 
> v2: reformatted as per request by Jeff Garzik <jgarzik@pobox.com>
>     "Enable foo (0=off, 1=on [default])"
> 
> Signed-off-by: Evgeni Golov <sargentd@die-welt.net>
> ---
>  drivers/ata/libata-core.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)

applied


