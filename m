From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA: link online but device misclassified
Date: Sat, 20 Jun 2009 21:34:00 +0900
Message-ID: <4A3CD738.1080105@gmail.com>
References: <cfa4e840906101715r56b643f4tab58e1c859d119ba@mail.gmail.com>	 <4A308798.6060803@gmail.com>	 <cfa4e840906110231u4e90eb22wbeb2d4e748c5624a@mail.gmail.com>	 <1244746872.3998.88.camel@mulgrave.site>	 <cfa4e840906111232i52decee3mf9ab2d0abcaa78d9@mail.gmail.com>	 <cfa4e840906160759m31db333cr555104ca0e3c6255@mail.gmail.com>	 <cfa4e840906160803h3364ac8aqfd78405dbcc512df@mail.gmail.com>	 <1245165697.3965.40.camel@mulgrave.site> <4A3AEC08.4060507@gmail.com>	 <4A3B0D49.8070802@gmail.com> <cfa4e840906190238m4cca2c73pece279bb642bfd1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f195.google.com ([209.85.222.195]:38802 "EHLO
	mail-pz0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbZFTMeD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Jun 2009 08:34:03 -0400
Received: by pzk33 with SMTP id 33so279818pzk.33
        for <linux-ide@vger.kernel.org>; Sat, 20 Jun 2009 05:34:05 -0700 (PDT)
In-Reply-To: <cfa4e840906190238m4cca2c73pece279bb642bfd1f@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc Bowes <marcbowes@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-ide@vger.kernel.org

Marc Bowes wrote:
> Hi,
> 
> Tejun, the motherboard is a Gigabyte EP45-DQ6. Attached are dmidecode
> and a new dmesg.txt, as I have enabled AHCI mode.

Yeah, you have 2 sil5723's hanging off the jmicron controller.  If you
have harddisks connected to those ports it will be okay.  If not,
they'll keep the link online but timeout on SRST.  Hmmm... not really
sure what to do yet.  Maybe we can do some sort of blacklisting.  I
wonder how windows copes with this.  Hmmm...

-- 
tejun
