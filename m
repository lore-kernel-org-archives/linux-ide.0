From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA: link online but device misclassified
Date: Thu, 02 Jul 2009 08:31:13 +0900
Message-ID: <4A4BF1C1.3040103@gmail.com>
References: <cfa4e840906101715r56b643f4tab58e1c859d119ba@mail.gmail.com>	 <cfa4e840906160759m31db333cr555104ca0e3c6255@mail.gmail.com>	 <cfa4e840906160803h3364ac8aqfd78405dbcc512df@mail.gmail.com>	 <1245165697.3965.40.camel@mulgrave.site> <4A3AEC08.4060507@gmail.com>	 <4A3B0D49.8070802@gmail.com>	 <cfa4e840906190238m4cca2c73pece279bb642bfd1f@mail.gmail.com>	 <4A3CD738.1080105@gmail.com>	 <cfa4e840906200613mac35e8ei69e40f9bcddd37dc@mail.gmail.com>	 <4A489562.8080404@gmail.com> <cfa4e840907010107s4d47c877n990594e660759cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.236]:8618 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbZGAXbQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Jul 2009 19:31:16 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1719578rvb.5
        for <linux-ide@vger.kernel.org>; Wed, 01 Jul 2009 16:31:18 -0700 (PDT)
In-Reply-To: <cfa4e840907010107s4d47c877n990594e660759cc@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc Bowes <marcbowes@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-ide@vger.kernel.org

Marc Bowes wrote:
> Hi Tejun,
> 
> The patch works as you intended it. There is still some timeout, but
> it is not more than 2-3 seconds which is a vast improvement. Attached
> is the new dmesg.

Thanks for verifying.  It still takes twenty seconds.  Do you have
async probing turned on?

-- 
tejun
