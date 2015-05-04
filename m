From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Blacklist queued TRIM on all Samsung 800-series
Date: Mon, 4 May 2015 12:29:37 -0400
Message-ID: <20150504162937.GE1971@htj.duckdns.org>
References: <mi84f3@ger.gmane.org>
 <1430756429-2258-1-git-send-email-martin.petersen@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:36225 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbbEDQ3k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 May 2015 12:29:40 -0400
Content-Disposition: inline
In-Reply-To: <1430756429-2258-1-git-send-email-martin.petersen@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org, g.wal@web.de, sven.koehler@gmail.com, stable@vger.kernel.org

On Mon, May 04, 2015 at 12:20:29PM -0400, Martin K. Petersen wrote:
> The queued TRIM problems appear to be generic to Samsung's firmware a=
nd
> not tied to a particular model. A recent update to the 840 EVO firmwa=
re
> introduced the same issue as we saw on 850 Pro.
>=20
> Blacklist queued TRIM on all 800-series drives while we work this iss=
ue
> with Samsung.
>=20
> Reported-by: G=FCnter Waller <g.wal@web.de>
> Reported-by: Sven K=F6hler <sven.koehler@gmail.com>
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: stable@vger.kernel.org

Patch applied.  Will push out in a couple days.

Thanks a lot for handling this.

--=20
tejun
