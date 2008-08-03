From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/2] pata_legacy: export functionality to ide
Date: Sun, 03 Aug 2008 19:43:43 -0400
Message-ID: <489642AF.3020708@pobox.com>
References: <20080715053356.GA18628@gollum.tnic>	<20080803073756.GA8762@gollum.tnic>	<20080803125907.67676948@lxorguk.ukuu.org.uk>	<200808031537.41224.bzolnier@gmail.com> <20080803143939.37a74bf5@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42300 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758898AbYHCXnz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Aug 2008 19:43:55 -0400
In-Reply-To: <20080803143939.37a74bf5@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, petkovbb@gmail.com, petkovbb@googlemail.com, alan@redhat.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Alan Cox wrote:
>> The code in question is 65 LOC total (43 LOC without counting comments)
>> so having a shared library just for it sounds like an overkill and we may
> 
> People expect code in C files, so in headers it gets missed as well as
> dumped in a directory with no correlation between file name and subsystem.
> 
>> just copy that one function from pata_legacy to ide_generic instead.
> 
> If you are going to  #include two copies you might as well just copy it.

That's pretty much my feeling...  just copy the code.

If the shared code grows larger, create a kernel module with the stuff 
shared by both libata and drivers/ide.

liblibata?  libata-core-core?  :)

	Jeff


