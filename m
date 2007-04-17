From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 4/4] libata: implement libata.spindown_compat
Date: Wed, 18 Apr 2007 02:09:47 +0900
Message-ID: <4624FF5B.9010000@gmail.com>
References: <20070320150718.GF6152@htj.dyndns.org>	 <20070320151359.GG6152@htj.dyndns.org>	 <20070320152533.GH6152@htj.dyndns.org>	 <20070320155548.GI6152@htj.dyndns.org>  <4624DD95.3070608@garzik.org>	 <1176822118.3671.32.camel@mulgrave.il.steeleye.com>	 <4624E5D8.6080806@garzik.org> <1176823590.3671.35.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <1176823590.3671.35.camel@mulgrave.il.steeleye.com>
Sender: linux-scsi-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, djwong@us.ibm.com, hmh@hmh.eng.br
List-Id: linux-ide@vger.kernel.org

James Bottomley wrote:
> On Tue, 2007-04-17 at 11:20 -0400, Jeff Garzik wrote:
>> then, unless there are dependencies in libata-dev, how about Tejun 
>> pushes patches 3-4 through scsi-misc as well?
> 
> Sure ... as long as there are no dependencies.

James, are you going to rebase scsi-misc-2.6 before sending to Linus
when 2.6.22-rc1 window opens?  If not, Jeff can pull it into libata-dev
and patch 3 and 4 can go in there.  The difference in libata between
scsi-misc-2.6 and libata-dev is rather large and applying 3 and 4 to
scsi-misc-2.6 would cause merging headache later.

Thanks.

-- 
tejun
