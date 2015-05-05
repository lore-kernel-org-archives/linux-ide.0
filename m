From: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/4] libata: Allow NCQ TRIM to be enabled or disabled
 with a module parameter
Date: Tue, 05 May 2015 16:07:46 +0200
Message-ID: <5548CEB2.9000106@suse.de>
References: <1430790861-30066-1-git-send-email-martin.petersen@oracle.com> <20150505133106.GK1971@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49306 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752295AbbEEOHs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 May 2015 10:07:48 -0400
In-Reply-To: <20150505133106.GK1971@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org

On 05/05/2015 03:31 PM, Tejun Heo wrote:
> On Mon, May 04, 2015 at 09:54:18PM -0400, Martin K. Petersen wrote:
>> We have started seeing SSD firmware updates introduce support for qu=
eued
>> TRIM. Sadly, in most cases this support is completely untested and c=
an
>> lead to either errors or data corruption.
>>
>> Add two libata force flags that can be used to either enable or disa=
ble
>> queued TRIM support.
>>
>> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
>=20
> Applied 1-4 to libata/for-4.2.
>=20
> Thanks.
>=20
As a side note: queue TRIM requires 'SEND FPDMA QUEUED', which is an
_optional_ part of the NCQ feature set.
And unfortunately there are no identify bits telling us whether SEND
=46PDMA QUEUE is actually implemented (or RECEIVE FPDMA QUEUED, for
that matter).
I've been advocating to implement this (it would come in very handy
for the SMR/ZAC stuff) but to no avail so far.
Needless to say, none of the drives I have implement SEND FPDMA
QUEUED...

Maybe it's an idea to poke the powers that be about additional
identify bits for this ...

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: F. Imend=F6rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N=FCrnberg)
