From: "Rune Torgersen" <runet@innovsys.com>
Subject: RE: locking problem in sata_sil24?
Date: Mon, 3 Mar 2008 17:13:31 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B0410A5BA@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B0410A524@ismail.innsys.innovsys.com> <1204583866.21545.31.camel@pasglop> <DCEAAC0833DD314AB0B58112AD99B93B0410A575@ismail.innsys.innovsys.com> <1204585095.21545.37.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.innovsys.com ([66.115.232.196]:41381 "EHLO
	mail.innovsys.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753282AbYCCXNe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Mar 2008 18:13:34 -0500
Content-class: urn:content-classes:message
In-Reply-To: <1204585095.21545.37.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org

> From: Benjamin Herrenschmidt
> In fact, I remember working on 64 bits lockdep, based on patches from
> Johannes, but I didn't do 32 bits. I think somebody worked on it, but
> now I can't find the patches...

http://patchwork.ozlabs.org/linuxppc/patch?id=16652

> Whoever did it can bounce them back to me ? I intend to do some more
> work on this soon.

