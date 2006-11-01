From: "Rune Torgersen" <runet@innovsys.com>
Subject: RE: SATA HSM error
Date: Wed, 1 Nov 2006 08:22:14 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B0189DFFA@ismail.innsys.innovsys.com>
References: <45480CDB.3050407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.innovsys.com ([66.115.232.196]:46209 "EHLO
	mail.innovsys.com") by vger.kernel.org with ESMTP id S1946899AbWKAOWP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Nov 2006 09:22:15 -0500
Content-class: urn:content-classes:message
In-Reply-To: <45480CDB.3050407@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

> From: Tejun Heo
> Rune Torgersen wrote:
> > ata2: illegal qc_active transition (00000002->000001f8)
> The driver says that the attached device is setting spurious command 
> active bits.  I have never seen this before.
I have only seen this on this particular drive so far.

> As it's the first report of this kind, I'm more inclined to 
> hw problem. 
>   Can you test with different drive?

I will shortly.
