From: David Ford <david+challenge-response@blue-labs.org>
Subject: Re: new tool:  blktool
Date: Sun, 15 Aug 2004 18:18:53 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <411FE14D.2080400@blue-labs.org>
References: <411FD744.2090308@pobox.com> <1092603321.18410.5.camel@localhost.localdomain> <411FDEA9.2010802@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040806050207070505060506"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:22961 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S267182AbUHOWQu
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Aug 2004 18:16:50 -0400
In-Reply-To: <411FDEA9.2010802@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------040806050207070505060506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

[...]

> Yep, it's more like ethtool(8) or cvs(1) in its syntax.  There is big 
> difference in usability (for me anyway) between "command [options]..." 
> and an unordered list of --args.  Especially as the list of commands 
> grows longer.  It provides more structure.
>
> Each command can have options, --foo-bar=baz if you like, I suppose.


I would rather see --option=xyz than option xyz.  End users are going to 
be using it in scripts and in the event a parameter becomes "", then it 
will become --option1= --option2=def instead of option1 option2 def.  I 
would find it easier to parse, --option= is easy to ignore, option 
option has to be recognized as an empty option instead of using option 
as the first option's argument.

Just my opinion,
-david


--------------040806050207070505060506
Content-Type: text/x-vcard; charset=utf-8;
 name="david+challenge-response.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="david+challenge-response.vcf"

begin:vcard
fn:David Ford
n:Ford;David
email;internet:david@blue-labs.org
title:Industrial Geek
tel;home:Ask please
tel;cell:(203) 650-3611
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------040806050207070505060506--
