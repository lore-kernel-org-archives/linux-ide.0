From: Timur Tabi <timur@freescale.com>
Subject: Re: "ahci: drop intx manipulation on msi enable" breaks ULI M1575
Date: Wed, 8 Apr 2009 17:15:46 -0500
Message-ID: <ed82fe3e0904081515k6e53de00g7d5256f9b61a03da@mail.gmail.com>
References: <49DB6914.1030107@freescale.com> <49DBE858.9040004@kernel.org>
	 <ed82fe3e0904071736w55dff582y8ac2681f6410865b@mail.gmail.com>
	 <1239156559.10104.7.camel@localhost>
	 <ed82fe3e0904080440w130b5dc5of6d5ed3051ed04e2@mail.gmail.com>
	 <49DD1154.3040106@kernel.org> <49DD11D1.7060105@freescale.com>
	 <49DD1375.8030400@kernel.org> <49DD1465.6070001@freescale.com>
	 <49DD17C3.7040607@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qy0-f118.google.com ([209.85.221.118]:43231 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753027AbZDHWPs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Apr 2009 18:15:48 -0400
Received: by qyk16 with SMTP id 16so702813qyk.33
        for <linux-ide@vger.kernel.org>; Wed, 08 Apr 2009 15:15:46 -0700 (PDT)
In-Reply-To: <49DD17C3.7040607@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: michael@ellerman.id.au, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Linux PPC Development <linuxppc-dev@ozlabs.org>

On Wed, Apr 8, 2009 at 4:31 PM, Tejun Heo <tj@kernel.org> wrote:
> Hmmm... for now,
> I think it would be best to revert the original change. =A0Jeff, can =
you
> please do that?

Actually, give me a few days before you do that.  A colleague gave me
some suggestions to debug this.

--=20
Timur Tabi
Linux kernel developer at Freescale
