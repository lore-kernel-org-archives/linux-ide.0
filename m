From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA: link online but device misclassified
Date: Wed, 08 Jul 2009 13:14:52 +0900
Message-ID: <4A541D3C.3040906@gmail.com>
References: <cfa4e840906101715r56b643f4tab58e1c859d119ba@mail.gmail.com>	 <1245165697.3965.40.camel@mulgrave.site> <4A3AEC08.4060507@gmail.com>	 <4A3B0D49.8070802@gmail.com>	 <cfa4e840906190238m4cca2c73pece279bb642bfd1f@mail.gmail.com>	 <4A3CD738.1080105@gmail.com>	 <cfa4e840906200613mac35e8ei69e40f9bcddd37dc@mail.gmail.com>	 <4A489562.8080404@gmail.com>	 <cfa4e840907010107s4d47c877n990594e660759cc@mail.gmail.com>	 <4A4BF1C1.3040103@gmail.com> <cfa4e840907020222ueef735bpcf220fe7f81097ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:53735 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbZGHEO7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Jul 2009 00:14:59 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1070645rvb.5
        for <linux-ide@vger.kernel.org>; Tue, 07 Jul 2009 21:14:57 -0700 (PDT)
In-Reply-To: <cfa4e840907020222ueef735bpcf220fe7f81097ae@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc Bowes <marcbowes@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-ide@vger.kernel.org

Marc Bowes wrote:
> # CONFIG_SCSI_SCAN_ASYNC is not set
> 
> Is that what you are referring to?

Eh... never mind.  Port probings are always serial.  Anyways, the
original patch collides with another fix.  I'll post a new version on
bko#13551.  Please test that one.

Thanks.

-- 
tejun
