From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH] ahci: display all AHCI 1.3 HBA capability flags (v2)
Date: Mon, 28 Sep 2009 20:34:12 -0600
Message-ID: <51f3faa70909281934o38b23679w72b8231e762412ba@mail.gmail.com>
References: <4AB6718C.2050107@gmail.com> <4AB69318.5050904@garzik.org>
	 <4AB6B487.3010907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f178.google.com ([209.85.223.178]:55152 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbZI2CeI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Sep 2009 22:34:08 -0400
Received: by iwn8 with SMTP id 8so2889497iwn.33
        for <linux-ide@vger.kernel.org>; Mon, 28 Sep 2009 19:34:12 -0700 (PDT)
In-Reply-To: <4AB6B487.3010907@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: ide <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>

On Sun, Sep 20, 2009 at 5:02 PM, Robert Hancock <hancockrwd@gmail.com> wrote:
> Update the AHCI driver to display all of the HBA capabilities defined in the
> AHCI 1.3 specification. Some of these are in a new CAP2 (HBA Capabilities
> Extended) register which is only defined on AHCI 1.2 or later. The spec says
> that undefined registers should always return 0 on read, but to be safe we
> assume a value of 0 unless the controller reports AHCI version 1.2 or later.
> The value can also be retrieved through sysfs as with the existing capability
> field.
>
> For example, on an Intel Ibex Peak (PCH) controller:
>
> ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pmp pio slum part ems
> sxs apst
>
> We don't do anything special with the new flags yet.
>
> Also, change the code that displays the flags to use the same bit enumerations
> that are used to control actual operation.
>
> Signed-off-by: Robert Hancock <hancockrwd@gmail.com>
>

Ping?
