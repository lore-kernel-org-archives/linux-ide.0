From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Off-by-one in both LIBATA and IDE drivers
Date: Wed, 11 Mar 2009 22:26:08 -0600
Message-ID: <49B88EE0.2000208@gmail.com>
References: <20090312022825.44571.qmail@web4106.mail.ogk.yahoo.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:51090 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbZCLE0O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Mar 2009 00:26:14 -0400
In-Reply-To: <20090312022825.44571.qmail@web4106.mail.ogk.yahoo.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: n0diamond@yahoo.co.jp
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Norman Diamond wrote:
> There's next to nothing that I can do about it.
> If the BIOS sets the Intel chip to present an ATA
> interface then the IDE drivers take control early in
> the boot process.  If the BIOS sets the Intel chip to
> present a SATA interface then LIBATA takes control
> early in the boot process.
> 
> I'm considering constructing a boot menu where the
> default command line has hda=noprobe hdb=noprobe
> hdc=noprobe hdd=noprobe, and an alternate boot option
> omits those.  Even if this will be reliable enough, it
> won't be easy to explain to customers (if you don't
> believe that then read some tech support stories).

I think that at some point the IDE drivers were updated to be less
aggressive about taking control of anything that looked like an IDE
controller, but I'm not certain. These kind of problems are kind of
inevitable when you configure two drivers that will attach to the same
device, it's hard to control which one will attach. (It's especially bad
if two drivers will attach to different parts of the same controller,
which is the combined mode fiasco we had for a while.)

Newer distributions like Fedora are generally setting CONFIG_IDE=n
entirely and avoid the problem.

> 
>> Realistically, although some people still work on
>> it, testing coverage of the old IDE drivers is not
>> that great these days, since most distributions no
>> longer use it.
> 
> Even Knoppix 6.0.1, whose kernel isn't too antique
> yet, assigned /dev/hda and /dev/hdc on my Dell D820
> with ICH7M.
> 
> --------------------------------------
> Power up the Internet with Yahoo! Toolbar.
> http://pr.mail.yahoo.co.jp/toolbar/

