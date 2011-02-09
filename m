From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Wed, 09 Feb 2011 14:45:48 -0500
Message-ID: <4D52EEEC.1020602@cfl.rr.com>
References: <4D51A648.20707@cfl.rr.com> <20110209085935.GE6558@htj.dyndns.org> <4D52B0B3.40900@cfl.rr.com> <20110209153714.558133d7@lxorguk.ukuu.org.uk> <20110209153601.GJ3770@htj.dyndns.org> <4D52E180.6020908@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.121]:58667 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175Ab1BITqm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2011 14:46:42 -0500
Received: from cdptpa-omtalb.mail.rr.com ([10.127.143.51])
          by cdptpa-qmta01.mail.rr.com with ESMTP
          id <20110209194641175.INKA2538@cdptpa-qmta01.mail.rr.com>
          for <linux-ide@vger.kernel.org>; Wed, 9 Feb 2011 19:46:41 +0000
In-Reply-To: <4D52E180.6020908@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <tj@kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On 2/9/2011 1:48 PM, Jeff Garzik wrote:
> On 02/09/2011 10:36 AM, Tejun Heo wrote:
>> Agreed.  We're screwed whether we unlock or leave it alone.  I think
>> the best way is to export the original size via sysfs and always
>> unlock and let dmraid and whatever stuff which expects metadata at the
>> end use the bios size.
> 
> Agreed...

Then why did you have libata default to NOT unlocking it, which seems to
be the correct thing to do?  When Ubuntu switched to libata they patched
it to default to unlocking the HPA because the old ide driver did.  This
seems wrong and causes breakage.  Tejun's patch seems to be a good
compromise between the two choices: unlock if you think it will help,
otherwise, don't, since it might hurt.
