From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] libata: allow sata_sil24 to opt-out of tag ordered
 submission
Date: Mon, 19 Jan 2015 09:27:26 -0500
Message-ID: <20150119142726.GG8140@htj.dyndns.org>
References: <20150116231225.18771.75061.stgit@viggo.jf.intel.com>
 <20150116231302.18771.62862.stgit@viggo.jf.intel.com>
 <54BA409E.4040901@cogentembedded.com>
 <20150119141249.GA8140@htj.dyndns.org>
 <54BD139E.7080204@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54BD139E.7080204@cogentembedded.com>
Sender: stable-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-ide@vger.kernel.org, Ronny Hegewald <Ronny.Hegewald@online.de>, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mon, Jan 19, 2015 at 05:24:30PM +0300, Sergei Shtylyov wrote:
> >Why is that a clear abuse?  Seems like a pretty typical use to me.
> 
>    This is my first reaction to statements like 'x = x < M ? x : 0'. I really
> prefer two-liners with *if* to them.

But that doesn't justify the "clear abuse" part at all.  I get that
different people may have different preferences but that's not what
you expressed.

Thanks.

-- 
tejun
