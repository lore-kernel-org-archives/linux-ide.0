From: Michal Suchanek <hramrach@centrum.cz>
Subject: Re: SATA PMP support
Date: Fri, 20 May 2011 11:20:16 +0200
Message-ID: <BANLkTinCqzDToLGuQVOY_vTLzDBv02tZuA@mail.gmail.com>
References: <BANLkTi=4oJvigsq7GPMuB8meX0XnDh4VWw@mail.gmail.com>
 <20110519153826.GM627@htj.dyndns.org> <BANLkTikrHcnpKZccYMi0+24THZPYP6bRfg@mail.gmail.com>
 <20110520091530.GE31426@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:35233 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935449Ab1ETJUh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 May 2011 05:20:37 -0400
Received: by ewy4 with SMTP id 4so1110457ewy.19
        for <linux-ide@vger.kernel.org>; Fri, 20 May 2011 02:20:36 -0700 (PDT)
In-Reply-To: <20110520091530.GE31426@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Hello

On 20 May 2011 11:15, Tejun Heo <tj@kernel.org> wrote:

>
>> [ =C2=A0 =C2=A03.080341] ahci 0000:00:1f.2: flags: 64bit ncq sntf le=
d clo pio ems sxs
>
> But in this case, the above is enough. =C2=A0Your controller doesn't
> support port multiplier. =C2=A0It doesn't have "pmp" flag set.

So the table at
https://ata.wiki.kernel.org/index.php/SATA_hardware_features listing
ICH10 as having CBS PMP support is bogus?

Thanks

Michal
