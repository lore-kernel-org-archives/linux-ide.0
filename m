From: Tejun Heo <htejun@gmail.com>
Subject: Re: laptop reboots right after hibernation
Date: Wed, 28 Nov 2007 10:09:10 +0900
Message-ID: <474CBFB6.4020105@gmail.com>
References: <473730F6.2010900@dbservice.com> <20071118105214.GB7299@ucw.cz> <4740692E.7010801@dbservice.com> <47409DA3.7070909@dbservice.com> <1195551141.2792.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.238]:17837 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbXK1BK3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 20:10:29 -0500
Received: by hu-out-0506.google.com with SMTP id 19so1358486hue
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 17:10:27 -0800 (PST)
In-Reply-To: <1195551141.2792.3.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kjartan Maraas <kmaraas@broadpark.no>
Cc: Tomas Carnecky <tom@dbservice.com>, Pavel Machek <pavel@ucw.cz>, linux-ide@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

Kjartan Maraas wrote:
> I get this exact error message on a normal first time boot here. I'm
> using the latest fedora development kernel which is 2.6.24-rc2-git6
> based. And I have the latest BIOS from HP IIRC.
> 
> This is an HP nc6400 intel based laptop:

Care to post boot dmesg?  Or does harddisk detection fail because of this?

-- 
tejun
