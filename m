From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] ahci: EM supported message type sysfs attribute
Date: Mon, 07 Mar 2011 16:49:38 +0100
Message-ID: <4D74FE92.3040201@suse.de>
References: <20110304085452.83B5EF90E1@ochil.suse.de> <20110304103956.7360a840@kcaccard-MOBL3>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58350 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751413Ab1CGPj3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Mar 2011 10:39:29 -0500
In-Reply-To: <20110304103956.7360a840@kcaccard-MOBL3>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: Tejun Heo <tj@kernel.org>, jgarzik@pobox.com, linux-ide@vger.kernel.org

On 03/04/2011 07:39 PM, Kristen Carlson Accardi wrote:
> On Fri, 04 Mar 2011 09:54:52 +0100
> hare@suse.de (Hannes Reinecke) wrote:
>=20
>>
>> This patch adds an sysfs attribute 'em_message_supported' to the
>> ahci host device which prints out the supported enclosure management
>> message types.
>=20
> Is it useful to display the host controllers supported em
> message types when libata only can support LED type?

Yes. libata might only support LED types currently.
However, as other types are defined as per spec
we'll be coming across those types eventually.

But with the current code we don't have any means of detecting them.
libata just prints out 'ems' at module load time, without any hint
which message type is actually supported.

With this patch we can now signal the presence of additional message
types to the user, allowing him to start hacking :-)

Incidentally, if you know of a chipset/board already supporting
different message types I'm all ears :-)

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: Markus Rex, HRB 16746 (AG N=FCrnberg)
