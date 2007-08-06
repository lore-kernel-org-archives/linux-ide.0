From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Disk spin down issue on shut down/suspend to disk
Date: Mon, 6 Aug 2007 11:23:39 -0300
Message-ID: <20070806142339.GA31615@khazad-dum.debian.net>
References: <838f88840708051428p3d65ff42w627af4bc38f57de3@mail.gmail.com> <46B6B006.6000100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:48940 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762192AbXHFOXo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Aug 2007 10:23:44 -0400
Content-Disposition: inline
In-Reply-To: <46B6B006.6000100@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Micha?? sed <sedmich@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org

On Mon, 06 Aug 2007, Tejun Heo wrote:
> Cc'ing Henrique.  Any ideas?

Check if /etc/init.d/halt is calling halt(8) with the -h flag.  If it is,
remove that -h flag.  Usually, there is a hddown variable that holds it, you
just need to get rid of it.

I don't know anything about a Sidux, though.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
