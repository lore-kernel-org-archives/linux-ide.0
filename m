From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v9 3/7] ata: libahci: allow to use multiple PHYs
Date: Wed, 09 Jul 2014 16:02:58 +0200
Message-ID: <53BD4B92.7030601@redhat.com>
References: <1404728173-20263-1-git-send-email-antoine.tenart@free-electrons.com> <1404728173-20263-4-git-send-email-antoine.tenart@free-electrons.com> <20140708134000.GC4979@htj.dyndns.org> <20140708170353.GA16148@kwain> <20140708171817.GH4979@htj.dyndns.org> <20140708174900.GC16148@kwain> <20140708214010.GI4979@htj.dyndns.org> <20140709082331.GA4510@kwain> <20140709135910.GA11193@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:30351 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753507AbaGIODe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Jul 2014 10:03:34 -0400
In-Reply-To: <20140709135910.GA11193@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, =?ISO-8859-1?Q?Antoine_T=E9nart?= <antoine.tenart@free-electrons.com>
Cc: sebastian.hesselbarth@gmail.com, kishon@ti.com, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 07/09/2014 03:59 PM, Tejun Heo wrote:
> Hello,
>=20
> On Wed, Jul 09, 2014 at 10:23:31AM +0200, Antoine T=E9nart wrote:
>>> It is confusing.  If you wanna pass around available ports in hpriv=
,
>>> please add a separate field and replace the arguments to
>>> save_initial_config().
>>
>> I don't get it. Which argument should I replace in
>> save_initial_config()? The change is we compute hpriv->port_map.
>> I don't see which arguments we can add or replace.
>=20
> The @force_port_map and @mask_port_map of ahci_save_initial_config().
> We end up with three params from two places modifying port_map and on=
e
> of those is in/out parameter, so ummm, no.  If you wanna add port
> masking to @hpriv, please do it by moving @force_port_map and
> @mask_port_map into @hpriv instead.
>=20
> Sure, the proposed change is small but the end result is messy.
>=20
>> I had a quick look on this, and it does not seems to be that simple.=
 The
>> ahci_port_priv is stored inside the ata_port struct and not accessib=
le
>> (as of now) from the ahci_host_priv one. The ahci_port_priv is
>> initialized at the end of ahci_platform_init_host(), far after we ne=
ed
>> it. This requires quite a lot of changes. Or is there another way?
>=20
> Yeah, it'd probably need separating out port resource handling, so
> that the order is get_resources, host_alloc, get_port_resources and
> then init and activate.  Hans, what do you think?

The order (and function names) you're suggesting here sound good to me.

Regards,

Hans
