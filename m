From: Tejun Heo <htejun@gmail.com>
Subject: Re: Disk spin down issue on shut down/suspend to disk
Date: Tue, 07 Aug 2007 03:43:08 +0900
Message-ID: <46B76BBC.9010107@gmail.com>
References: <838f88840708051428p3d65ff42w627af4bc38f57de3@mail.gmail.com>	 <1186411815.4355.7.camel@nx6310>	 <20070806150159.GC31615@khazad-dum.debian.net>	 <200708061732.03425.rjw@sisk.pl>  <46B75459.9020204@gmail.com> <1186424492.4355.1.camel@nx6310>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:19332 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932443AbXHFSoL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Aug 2007 14:44:11 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1194742rvb
        for <linux-ide@vger.kernel.org>; Mon, 06 Aug 2007 11:44:11 -0700 (PDT)
In-Reply-To: <1186424492.4355.1.camel@nx6310>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Sedkowski <sedmich@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org

Michael Sedkowski wrote:
>> Hmmm... If the problem only shows up on nx6325, it might be that ACPI is
>> pulling unnecessary stunt.  Please apply the attached patch and report
>> when the disk spins down and up.
> 
> Disk spins down on "Pre-shutdown prepare" and then goes up and down on
> "Power down".

Oh... crap, so acpi wants to sync cache on shutdown.  I wonder whether
it spins down the disk correctly.  Does emergency unload count increase
after each power down?  Also, please post the result of 'dmidecode'.

Thanks.

-- 
tejun
