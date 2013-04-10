From: "Jan Beulich" <JBeulich@suse.com>
Subject: Re: regarding your patch "AHCI: Support multiple MSIs"
Date: Wed, 10 Apr 2013 17:36:35 +0100
Message-ID: <5165B13302000078000CC3BC@nat28.tlf.novell.com>
References: <51659BDA02000078000CC288@nat28.tlf.novell.com>
 <20130410154202.GA2137@dhcp-26-207.brq.redhat.com>
 <5165A67802000078000CC2DD@nat28.tlf.novell.com>
 <20130410163250.GB2137@dhcp-26-207.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nat28.tlf.novell.com ([130.57.49.28]:50244 "EHLO
	nat28.tlf.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934881Ab3DJQgh convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-ide@vger.kernel.org:3:1>);
	Wed, 10 Apr 2013 12:36:37 -0400
In-Reply-To: <20130410163250.GB2137@dhcp-26-207.brq.redhat.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Gordeev <agordeev@redhat.com>
Cc: mingo@elte.hu, jgarzik@redhat.com, linux-ide@vger.kernel.org

>>> On 10.04.13 at 18:32, Alexander Gordeev <agordeev@redhat.com> wrote:
> On Wed, Apr 10, 2013 at 04:50:48PM +0100, Jan Beulich wrote:
>> They have separate lines, but all say just "ahci" at the end (as
>> opposed to e.g. all the USB consumed ones, which are nicely
>> distinguishable).
> 
> That is seems possible. Will have to check side effects though.
> 
> If *-ahci in case of single interrupt and *-ahciN where N is port #
> works for you?

Something like that would surely do.

Jan

