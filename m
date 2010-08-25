From: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: sata_sil boot failure with 2.6.35
Date: Wed, 25 Aug 2010 09:20:41 +0100
Message-ID: <4C74EE7902000078000120E2@vpn.id2.novell.com>
References: <4C6EC878020000780001146D@vpn.id2.novell.com>
 <4C6ED603.9020602@garzik.org> <4C724D3E.50404@kernel.org>
 <4C728C5E0200007800011887@vpn.id2.novell.com>
 <4C727E80.3060402@kernel.org>
 <4C72B4250200007800011998@vpn.id2.novell.com> <4C73CE8A.406@kernel.org>
 <4C73FEA60200007800011F51@vpn.id2.novell.com>
 <4C73E263.5050102@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <4C73E263.5050102@kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, jgarzik@redhat.com, linux-ide@vger.kernel.org

>>> On 24.08.10 at 17:16, Tejun Heo <tj@kernel.org> wrote:
> On 08/24/2010 05:17 PM, Jan Beulich wrote:
>>> The only thing I can think of is the following.  Can you please try
>>> this one?  If this one fails, we might have to resort to bisecting.
>>> It's very weird.  The sff common code is used by other controllers but
>>> until now the problem is only being reported on sata_sil.
>> 
>> Sorry - again no (visible) difference.
> 
> Any chance I can persuade you into bisecting the problem? :-) Also,
> can you please attach the output of lspci -nn output and .config?

I'll see if I can find time, but I can give no estimate. However, the
box I see this on (AMD Sahara Rev F) likely has a number of
duplicates in our labs, so maybe you could try reproducing it there?

Jan

