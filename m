From: "Tvrtko A. Ursulin" <tvrtko@ursulin.net>
Subject: [RESOLVED] Re: libata errors with smartctl on 2.6.24, WD3200AAKS and nVidia AHCI
Date: Wed, 14 May 2008 09:05:29 +0100
Message-ID: <200805140905.29426.tvrtko@ursulin.net>
References: <alpine.BSF.1.00.0805140952250.34461@anduin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mk-outboundfilter-5-a-2.mail.uk.tiscali.com ([212.74.114.4]:59683
	"EHLO mk-outboundfilter-5-a-2.mail.uk.tiscali.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753287AbYENIFe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 May 2008 04:05:34 -0400
In-Reply-To: <alpine.BSF.1.00.0805140952250.34461@anduin.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Inge =?iso-8859-1?q?Bols=F8?= <knan-ide@anduin.net>
Cc: htejun@gmail.com, linux-ide@vger.kernel.org

On Wednesday 14 May 2008 08:58:56 Erik Inge Bols=F8 wrote:
> The drive does say
>
>         Enabled Supported:
>                 SMART feature set
>                 Security Mode feature set
>            *    Power Management feature set
>            *    Write cache
>            *    Look-ahead
>
> ... so doesn't look like SMART is enabled on the drive.
>
> Does the problem go away if you do a
>
> smartctl -s on /dev/sda
>
> first? :)

Indeed it does, shame on me for overseeing that small detail. :)=20

Thanks,

Tvrtko
